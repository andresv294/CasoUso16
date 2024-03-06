
package CasoUso16;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.ResultSet;
import javax.swing.JOptionPane;

/**
 *
 * @author star
 */
public class ActualizarAmbientes {

    public static void main(String[] args) {
        String usuario = "root";
        String password = "123456789";
        String url = "jdbc:mysql://localhost:3306/bd_timecrafters";
        Statement statement;
        ResultSet rs;

        try {

            Class.forName("com.mysql.cj.jdbc.Driver");

            Connection conexion = DriverManager.getConnection(url, usuario, password);
            Statement st = conexion.createStatement();

            String idAmbienteString = JOptionPane.showInputDialog("Ingrese el ID del ambiente a actualizar:");
            int idAmbiente = Integer.parseInt(idAmbienteString);

            String nuevoNombreAmbiente = JOptionPane.showInputDialog("Ingrese el nuevo nombre de ambiente:");

            conexion = DriverManager.getConnection(url, usuario, password);
            statement = conexion.createStatement();

            String query = "UPDATE ambientes SET ambientes_nombre = '" + nuevoNombreAmbiente + "' WHERE ambientes_id = " + idAmbiente;
            statement.executeUpdate(query);

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
