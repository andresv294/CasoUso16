
package CasoUso16;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.ResultSet;
import javax.swing.JOptionPane;
import java.sql.PreparedStatement;

public class GestionarAmbientes {

    public static void main(String[] args) {
        String usuario = "root";
        String password = "123456789";
        String url = "jdbc:mysql://localhost:3306/bd_timecrafters";
        Connection conexion = null;
        Statement statement = null;
        ResultSet rs = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");

            boolean salir = false;

            while (!salir) {
                String opcion = JOptionPane.showInputDialog("Seleccione una opción:\n"
                        + "1. Insertar ambiente\n"
                        + "2. Actualizar ambiente\n"
                        + "3. Eliminar ambiente\n"
                        + "4. Consultar ambiente por ID\n"
                        + "5. Consultar todos los ambientes\n"
                        + "6. Salir");

                if (opcion != null) {
                    switch (opcion) {
                        case "1":
                            String nombreAmbiente = JOptionPane.showInputDialog(null, "Ingrese el nombre del ambiente:");
                            if (nombreAmbiente != null) {
                                conexion = DriverManager.getConnection(url, usuario, password);
                                String sqlInsert = "INSERT INTO ambientes(ambientes_nombre) VALUES (?)";
                                try (PreparedStatement preparedStatement = conexion.prepareStatement(sqlInsert)) {
                                    preparedStatement.setString(1, nombreAmbiente);
                                    preparedStatement.executeUpdate();
                                    JOptionPane.showMessageDialog(null, "El ambiente se ha insertado correctamente.");
                                }
                                conexion.close();
                            }
                            break;

                        case "2":
                            String idAmbienteString = JOptionPane.showInputDialog("Ingrese el ID del ambiente a actualizar:");
                            if (idAmbienteString != null) {
                                int idAmbiente = Integer.parseInt(idAmbienteString);
                                String nuevoNombreAmbiente = JOptionPane.showInputDialog("Ingrese el nuevo nombre de ambiente:");
                                if (nuevoNombreAmbiente != null) {
                                    conexion = DriverManager.getConnection(url, usuario, password);
                                    statement = conexion.createStatement();
                                    String query = "UPDATE ambientes SET ambientes_nombre = '" + nuevoNombreAmbiente + "' WHERE ambientes_id = " + idAmbiente;
                                    statement.executeUpdate(query);
                                    JOptionPane.showMessageDialog(null, "El ambiente se ha actualizado correctamente.");
                                    conexion.close();
                                }
                            }
                            break;

                        case "3":
                            String idEliminarString = JOptionPane.showInputDialog("Ingrese el ID del ambiente a eliminar:");
                            if (idEliminarString != null) {
                                int idEliminar = Integer.parseInt(idEliminarString);
                                conexion = DriverManager.getConnection(url, usuario, password);
                                statement = conexion.createStatement();
                                String sqlEliminar = "DELETE FROM ambientes WHERE ambientes_id = " + idEliminar;
                                int filasAfectadas = statement.executeUpdate(sqlEliminar);
                                if (filasAfectadas > 0) {
                                    JOptionPane.showMessageDialog(null, "El ambiente ha sido eliminado correctamente.");
                                } else {
                                    JOptionPane.showMessageDialog(null, "No se encontró ningún ambiente con el ID proporcionado.");
                                }
                                conexion.close();
                            }
                            break;

                        case "4":
                            String idConsultarString = JOptionPane.showInputDialog("Ingrese el ID del ambiente a consultar:");
                            if (idConsultarString != null) {
                                int idConsultar = Integer.parseInt(idConsultarString);
                                conexion = DriverManager.getConnection(url, usuario, password);
                                statement = conexion.createStatement();
                                rs = statement.executeQuery("SELECT * FROM ambientes WHERE ambientes_id = " + idConsultar);
                                StringBuilder sb = new StringBuilder();
                                boolean encontrado = false; // Variable para controlar si se encontró el ambiente
                                while (rs.next()) {
                                    sb.append("ID: ").append(idConsultar).append("\n");
                                    sb.append("Nombre: ").append(rs.getString("ambientes_nombre")).append("\n");
                                    encontrado = true;
                                }
                                if (!encontrado) {
                                    JOptionPane.showMessageDialog(null, "No se encontró ningún ambiente con el ID proporcionado.");
                                } else {
                                    JOptionPane.showMessageDialog(null, sb.toString());
                                }
                                conexion.close();
                            }
                            break;

                        case "5":
                            // Consultar todos los ambientes
                            conexion = DriverManager.getConnection(url, usuario, password);
                            statement = conexion.createStatement();
                            rs = statement.executeQuery("SELECT * FROM ambientes");
                            StringBuilder sb = new StringBuilder();
                            while (rs.next()) {
                                sb.append("ID: ").append(rs.getInt("ambientes_id")).append(" \tNombre: ").append(rs.getString("ambientes_nombre")).append("\n");
                            }
                            JOptionPane.showMessageDialog(null, sb.toString());
                            conexion.close();
                            break;

                        case "6":
                            salir = true;
                            break;

                        default:
                            JOptionPane.showMessageDialog(null, "Opción no válida.");
                            break;
                    }
                } else {
                    JOptionPane.showMessageDialog(null, "Operación cancelada por el usuario.");
                    salir = true;
                }
            }

        } catch (ClassNotFoundException | SQLException ex) {
            ex.printStackTrace();
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                if (statement != null) {
                    statement.close();
                }
                if (conexion != null) {
                    conexion.close();
                }
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
        }
    }
}
