package CasoUso16;

import com.sun.tools.javac.Main;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Scanner;
import java.util.logging.Level;
import java.util.logging.Logger;
import java.sql.ResultSet;
import javax.swing.JOptionPane;

/**
 *
 * @author star
 */
public class EliminarAmbientes {

    public static void main(String[] args) {

        String usuario = "root";
        String password = "123456789";
        String url = "jdbc:mysql://localhost:3306/bd_timecrafters";
//        Connection  conexion;
        Statement statement;
        ResultSet rs;
//        
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");

            // Solicitar al usuario que ingrese el ID del ambiente a eliminar
            String idAmbienteString = JOptionPane.showInputDialog(null, "Ingrese el ID del ambiente a eliminar:");
            int idAmbiente = Integer.parseInt(idAmbienteString);

            Connection conexion = DriverManager.getConnection(url, usuario, password);
            Statement st = conexion.createStatement();

            // Ejecutar la consulta SQL de eliminación
            String sql = "DELETE FROM ambientes WHERE ambientes_id = " + idAmbiente;
            int filasAfectadas = st.executeUpdate(sql);

            // Verificar si se eliminó correctamente el registro
            if (filasAfectadas > 0) {
                JOptionPane.showMessageDialog(null, "El ambiente ha sido eliminado correctamente.");
            } else {
                JOptionPane.showMessageDialog(null, "No se encontró ningún ambiente con el ID proporcionado.");
            }
            rs = st.executeQuery("SELECT * FROM ambientes");

            System.out.println("ID\tNombre Ambiente");
            while (rs.next()) {
                System.out.println(rs.getInt("ambientes_id") + "\t" + rs.getString("ambientes_nombre"));
            }

            conexion.close();

        } catch (ClassNotFoundException | SQLException ex) {
            ex.printStackTrace();
        }
    }
}
