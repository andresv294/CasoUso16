
package CasoUso16;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Scanner;
import java.sql.ResultSet;
import javax.swing.JOptionPane;

public class InsertarAmbientes {

    public static void main(String[] args) {

        String usuario = "root";
        String password = "123456789";
        String url = "jdbc:mysql://localhost:3306/bd_timecrafters";
        Connection conexion = null;
        Statement statement = null;
        ResultSet rs;


//        
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conexion = DriverManager.getConnection(url, usuario, password);
            statement = conexion.createStatement();
            Statement st = conexion.createStatement();

            String nombreAmbiente = JOptionPane.showInputDialog(null, "Ingrese el nombre del ambiente:");

            String query = "INSERT INTO ambientes(ambientes_nombre) VALUES ('" + nombreAmbiente + "')";
            statement.executeUpdate(query);

            JOptionPane.showMessageDialog(null, "El ambiente se ha insertado correctamente.");

            rs = st.executeQuery("SELECT * FROM ambientes");

            System.out.println("ID\tNombre Ambiente");
            while (rs.next()) {
                System.out.println(rs.getInt("ambientes_id") + "\t" + rs.getString("ambientes_nombre"));
            }

            conexion.close();

        } catch (ClassNotFoundException | SQLException ex) {
            ex.printStackTrace();
        } finally {
            try {
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
