
## Document-based Recommender system for Book (2019.06-2020.01)

### ๐ ๋์ผํ ์นดํ๊ณ ๋ฆฌ ๋ด ์ ์ฌํ ๋ด์ฉ๊ณผ ๊ตฌ๋งค์ ๋ถํฌ๋ฅผ ๊ฐ์ง ์ฑ์ ์ถ์ฒ ๋ชจ๋ธ ๊ตฌํ
> [Slideshare](https://www.slideshare.net/BOAZbigdata/11-boaz-boaz) 
> (Document/Content-based Recommender System for book)
> 
> Ideation : ebook ๊ตฌ๋ ์๋น์ค ๋ชจ๋ฐ์ผ ํ๋ซํผ์ ์ฆ๊ฐํ๋๋ฐ, ๋ด๊ฐ ์ฝ์ ์ฑ๊ณผ ์ ์ฌํ ๋ด์ฉ์ ์ฑ์ ์ถ์ฒํด์ฃผ๋ ์๋น์ค๋ ์์๊น?

</br>
  
#### ๐ ํ๋ก์ ํธ ์์ธ

> - **๋ฐ์ดํฐ ์์ง ๋ฐ ์ ์ฒ๋ฆฌ** [`Crawling Code (Python)`](https://gist.github.com/ttobaegi/21828c6952c7cf8249f738b1f7d5449b)
>    - ๋ฐ์ดํฐ ์ถ์ฒ ๋ฐ ์ ์  ์ด์  : ์๋ผ๋, ์ค์  ์ฑ ์์ ๋ฌธ์ฅ๋ฌธ๋จ ์ธ์ฉ๋ฌธ๊ณผ ๊ตฌ๋งค์ ๋ถํฌ ํ์ ๊ฐ๋ฅ 
>    - ๋ฐ์ดํฐ ์์ง : 7๊ฐ ์นดํ๊ณ ๋ฆฌ ๋ด 2018๋ ๋ฒ ์คํธ์๋ฌ & ์คํ๋์๋ฌ์ ์ฑ ๋ฐ์ดํฐ ํฌ๋กค๋ง
>      (๊ฒฝ์  ๊ฒฝ์, ๊ณผํ, ๋ํ๊ต์ฌ/์ ๋ฌธ์์ , ์์ค/์/ํฌ๊ณก, ์ด๋ฆฐ์ด, ์์ธ์ด, ์๊ธฐ๊ณ๋ฐ)
>        - ํ์คํธ : ์ฑ ๊ธฐ๋ณธ์ ๋ณด, ์ง์์ด, ์ธ์ฉ๋ฌธ(์ฑ์์์), ๊ตฌ๋งค์ ๋ถํฌ
>        - ์ด๋ฏธ์ง : ์ฑ ํ์ง
>        
> - **๋ชจ๋ธ๋ง** [`Modeling Code (Python)`](https://gist.github.com/ttobaegi/b123f2a714642f958a94157b83cd38e4)  
>    - Tokenizer : Komoran 
>    
>       โ ํํ์ ๋ถ์๊ธฐ ์ค ์๋๊ฐ ๋น ๋ฅธ Komoran ์ฌ์ฉ   
>    - Training algorithm : **Distributed memory PV-DM** 
>    
>       โ ์ ์ฌํ ๋ด์ฉ์ ๋์ ์ถ์ฒ์ด ๋ชฉ์ ์ด๋ฏ๋ก ๋ฌธ๋งฅ ๊ณ ๋ คํ๋ Distributed Memory Model ์ฌ์ฉ
>        - Distributed Memory model preserves the **word order in a document** whereas Distributed Bag of words just uses the bag of words approach, which doesnโt preserve any word order. 
>
>        
>     ```
>     from konlpy.tag import Komoran
>     from gensim.models.doc2vec import Doc2Vec, TaggedDocument
>     ```


