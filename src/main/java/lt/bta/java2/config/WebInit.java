package lt.bta.java2.config;

import org.springframework.data.rest.webmvc.RepositoryRestDispatcherServlet;
import org.springframework.web.WebApplicationInitializer;
import org.springframework.web.context.ContextLoaderListener;
import org.springframework.web.context.support.AnnotationConfigWebApplicationContext;
import org.springframework.web.servlet.DispatcherServlet;

import javax.servlet.MultipartConfigElement;
import javax.servlet.ServletContext;
import javax.servlet.ServletRegistration;

public class WebInit implements WebApplicationInitializer {

    @Override
    public void onStartup(ServletContext servletContext) {

        // Create the 'root' Spring application context
        AnnotationConfigWebApplicationContext rootContext = new AnnotationConfigWebApplicationContext();
        rootContext.register(AppConfig.class);

        // Manage the lifecycle of the application context
        servletContext.addListener(new ContextLoaderListener(rootContext));


        // Register and map the Spring Data Rest dispatcher servlet (must be before DispatcherServlet, why???):
        ServletRegistration.Dynamic rest = servletContext.addServlet("rest", RepositoryRestDispatcherServlet.class);
        rest.setLoadOnStartup(1);
        rest.addMapping("/api/*");


        // Create Dispatcher context
        AnnotationConfigWebApplicationContext dispatcherContext = new AnnotationConfigWebApplicationContext();
        dispatcherContext.register(MvcConfig.class);


        // Register and map the dispatcher servlet:
        ServletRegistration.Dynamic dispatcher = servletContext.addServlet("dispatcher", new DispatcherServlet(dispatcherContext));
        dispatcher.setLoadOnStartup(1);
        dispatcher.addMapping("/");
        dispatcher.setMultipartConfig(getMultipartConfigElement());
    }

    private MultipartConfigElement getMultipartConfigElement() {
        return new MultipartConfigElement( LOCATION, MAX_FILE_SIZE, MAX_REQUEST_SIZE, FILE_SIZE_THRESHOLD);
    }

    private static final String LOCATION = "/tmp";
    private static final long MAX_FILE_SIZE = 5 * 1024 * 1024; // 5MB: Max one file size
    private static final long MAX_REQUEST_SIZE = 20 * 1024 * 1024; // 20MB: Total request size
    private static final int FILE_SIZE_THRESHOLD = 2 * 1024 * 1024; // 2MB: Size threshold after which files will be written to disk

}
