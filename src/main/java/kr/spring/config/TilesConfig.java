package kr.spring.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.view.UrlBasedViewResolver;
import org.springframework.web.servlet.view.tiles3.TilesConfigurer;
import org.springframework.web.servlet.view.tiles3.TilesView;

@Configuration
public class TilesConfig {

    /**
     * Tiles 설정 파일의 위치를 등록
     */
    @Bean
    public TilesConfigurer tilesConfigurer() {

        TilesConfigurer configurer =
                new TilesConfigurer();

        configurer.setDefinitions(
                "/WEB-INF/tiles/tiles.xml"
        );

        // 개발 중 tiles.xml을 수정하면 반영
        configurer.setCheckRefresh(true);

        return configurer;
    }

    /**
     * Controller가 반환한 View 이름을
     * Tiles 정의에서 먼저 찾도록 설정
     */
    @Bean
    public UrlBasedViewResolver tilesViewResolver() {

        UrlBasedViewResolver resolver =
                new UrlBasedViewResolver();

        resolver.setViewClass(TilesView.class);

        // 숫자가 작을수록 먼저 실행
        resolver.setOrder(0);

        return resolver;
    }
}