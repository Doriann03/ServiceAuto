package ro.serviceauto.serviceauto.util;

import com.mysql.cj.jdbc.AbandonedConnectionCleanupThread;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.annotation.WebListener;
import java.sql.Driver;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Enumeration;

// Adnotarea @WebListener spune serverului Tomcat sa incarce aceasta clasa la pornire
@WebListener
public class AppContextListener implements ServletContextListener {

    @Override
    public void contextInitialized(ServletContextEvent sce) {
        // Aici putem pune cod care sa ruleze la PORNIREA aplicatiei
        System.out.println("--- ServiceAuto Application Started ---");
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        // Aici punem cod care sa ruleze la OPRIREA aplicatiei
        System.out.println("--- ServiceAuto Application Stopping... Cleaning up resources ---");

        // 1. Deregistram driverele JDBC (MySQL) pentru a evita memory leaks
        Enumeration<Driver> drivers = DriverManager.getDrivers();
        while (drivers.hasMoreElements()) {
            Driver driver = drivers.nextElement();
            try {
                DriverManager.deregisterDriver(driver);
                System.out.println("Deregistering JDBC driver: " + driver);
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        // 2. Oprim fortat thread-ul de cleanup al MySQL (Asta rezolva eroarea ta specifica)
        try {
            AbandonedConnectionCleanupThread.checkedShutdown();
            System.out.println("MySQL AbandonedConnectionCleanupThread stopped.");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}