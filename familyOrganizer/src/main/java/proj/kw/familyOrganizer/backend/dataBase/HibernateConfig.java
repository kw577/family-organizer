package proj.kw.familyOrganizer.backend.dataBase;

import java.util.Properties;

import javax.sql.DataSource;

import org.apache.commons.dbcp2.BasicDataSource;
import org.hibernate.SessionFactory;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.orm.hibernate5.HibernateTransactionManager; 
import org.springframework.orm.hibernate5.LocalSessionFactoryBuilder; 
import org.springframework.transaction.annotation.EnableTransactionManagement;

@Configuration
@ComponentScan(basePackages={"proj.kw.familyOrganizer.backend.dto"})
@EnableTransactionManagement
public class HibernateConfig {

	//MySQL Database
	//private final static String DATABASE_URL = "jdbc:mysql://localhost:3306/family_organizer"; 
	//private final static String DATABASE_DRIVER = "com.mysql.jdbc.Driver";
	//private final static String DATABASE_DIALECT = "org.hibernate.dialect.MySQLDialect";

	//private final static String DATABASE_USERNAME = "root";
	//private final static String DATABASE_PASSWORD = "";


	//Postgres Database
	private final static String DATABASE_URL = "jdbc:postgresql://localhost:5432/family_organizer"; 
	private final static String DATABASE_DRIVER = "org.postgresql.Driver";
	private final static String DATABASE_DIALECT = "org.hibernate.dialect.PostgreSQLDialect";

	private final static String DATABASE_USERNAME = "postgres";
	private final static String DATABASE_PASSWORD = "postgresAdmin";
	
	
	
	
	@Bean("dataSource")
	public DataSource getDataSource() {

		BasicDataSource dataSource = new BasicDataSource();

		dataSource.setDriverClassName(DATABASE_DRIVER);
		dataSource.setUrl(DATABASE_URL);

		dataSource.setUsername(DATABASE_USERNAME);
		dataSource.setPassword(DATABASE_PASSWORD);


		return dataSource;

	}


	// ustanawia sesje polaczenia z baza danych
	@Bean
	public SessionFactory getSessionFactory(DataSource dataSource) {

		LocalSessionFactoryBuilder builder = new LocalSessionFactoryBuilder(dataSource);

		builder.addProperties(getHibernateProperties());
		builder.scanPackages("proj.kw.familyOrganizer.backend.dto");

		return builder.buildSessionFactory();

	}


	// zwraca informacje o konfiguracji hibernate
	private Properties getHibernateProperties() {

		Properties properties = new Properties();


		properties.put("hibernate.dialect", DATABASE_DIALECT);		
		properties.put("hibernate.show_sql", "true");
		properties.put("hibernate.format_sql", "true");


		return properties;
	}


	@Bean
	public HibernateTransactionManager getTransactionManager(SessionFactory sessionFactory) {
		HibernateTransactionManager transactionManager = new HibernateTransactionManager(sessionFactory);
		return transactionManager;
	}


}