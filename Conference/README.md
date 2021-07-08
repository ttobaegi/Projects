
## Document-based Recommender system for Book (2019.06-2020.01)

### 📍 동일한 카테고리 내 유사한 내용과 구매자 분포를 가진 책을 추천 모델 구현
> [Slideshare](https://www.slideshare.net/BOAZbigdata/11-boaz-boaz) 
> (Document/Content-based Recommender System for book)
> 
> Ideation : ebook 구독 서비스 모바일 플랫폼은 증가하는데, 내가 읽은 책과 유사한 내용의 책을 추천해주는 서비스는 없을까?

</br>
  
#### 📍 프로젝트 상세

> - **데이터 수집 및 전처리** [`Crawling Code (Python)`](https://gist.github.com/ttobaegi/21828c6952c7cf8249f738b1f7d5449b)
>    - 데이터 출처 및 선정 이유 : 알라딘, 실제 책 속의 문장문단 인용문과 구매자 분포 파악 가능 
>    - 데이터 수집 : 7개 카테고리 내 2018년 베스트셀러 & 스테디셀러의 책 데이터 크롤링
>      (경제 경영, 과학, 대학교재/전문서적, 소설/시/희곡, 어린이, 에세이, 자기계발)
>        - 텍스트 : 책 기본정보, 지은이, 인용문(책속에서), 구매자 분포
>        - 이미지 : 책 표지
>        
> - **모델링** [`Modeling Code (Python)`](https://gist.github.com/ttobaegi/b123f2a714642f958a94157b83cd38e4)  
>    - Tokenizer : Komoran     
>    - Training algorithm : **Distributed memory PV-DM** 
>        - Distributed Memory model preserves the **word order in a document** whereas Distributed Bag of words just uses the bag of words approach, which doesn’t preserve any word order. 
>        
>     ```
>     from konlpy.tag import Komoran
>     from gensim.models.doc2vec import Doc2Vec, TaggedDocument
>     ```


