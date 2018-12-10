package lt.bta.java2.config;

import com.fasterxml.jackson.databind.SerializationFeature;
import com.fasterxml.jackson.datatype.hibernate5.Hibernate5Module;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Import;
import org.springframework.http.converter.json.Jackson2ObjectMapperFactoryBean;
import org.springframework.http.converter.json.MappingJackson2HttpMessageConverter;

@Configuration
@Import({PersistenceJPAConfig.class})
public class AppConfig {

    @Bean
    public MappingJackson2HttpMessageConverter customConverter() {
        MappingJackson2HttpMessageConverter converter = new MappingJackson2HttpMessageConverter();
        converter.setObjectMapper(customObjectMapper().getObject());
        return converter;
    }

    @Bean
    public Jackson2ObjectMapperFactoryBean customObjectMapper() {
        Jackson2ObjectMapperFactoryBean factoryBean = new Jackson2ObjectMapperFactoryBean();
        factoryBean.setFeaturesToDisable(SerializationFeature.WRITE_DATES_AS_TIMESTAMPS);
        factoryBean.setModulesToInstall(Hibernate5Module.class);
        return factoryBean;
    }

}
