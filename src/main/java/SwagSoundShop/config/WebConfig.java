package SwagSoundShop.config;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
public class WebConfig implements WebMvcConfigurer {

    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {
        String newUploadPath = "file:" + System.getProperty("user.dir") + "/uploads/";
        String oldUploadPath = "file:" + System.getProperty("user.dir") + "/src/main/resources/static/uploads/";

        registry.addResourceHandler("/uploads/**")
                .addResourceLocations(newUploadPath, oldUploadPath);
    }
}