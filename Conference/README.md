
## Document-based Recommender system for Book (2019.06-2020.01)
  * 동일한 카테고리 내 유사한 내용과 구매자 분포를 가진 책을 추천하는 서비스 구현 프로젝트 
    * Ideation : ebook 구독 서비스를 제공하는 모바일 플랫폼은 증가하는데, 유사한 내용의 책을 추천해주는 서비스는 없을까?

    * 데이터 수집
      * **베스트 셀러 & 스테디 셀러 각 카테고리 별 2018년도의 베스트셀러, 스테디 셀러 약 2000권의 책** (경제 경영, 과학, 대학교재/전문서적, 소설/시/희곡, 어린이, 에세이, 자기계발)
      * WebCrawler (text, image)
        1. [text 크롤링 코드] 
        2. [image 크롤링 코드](https://nbviewer.jupyter.org/github/ttobaegi/Projects/blob/main/Conference/1_CRAWLING_img_crawl.ipynb)
    * 모델링
       1. [Word2Vec](https://nbviewer.jupyter.org/github/ttobaegi/Projects/blob/main/Conference/3_MODELING_WordEmb.ipynb)
       2. [Doc2Vec](https://nbviewer.jupyter.org/github/ttobaegi/Projects/blob/main/Conference/3_MODELING.ipynb)
       3. [Clustering](https://nbviewer.jupyter.org/github/ttobaegi/Projects/blob/main/Conference/3_MODELING_Clustering.ipynb)  
  
> [프로젝트 발표 자료](https://www.slideshare.net/BOAZbigdata/11-boaz-boaz)
