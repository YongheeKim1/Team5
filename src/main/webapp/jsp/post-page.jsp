<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${post.title} - <spring:message code="community.title"/></title>

    <style>
        .community-title { text-align: center; font-size: 2em; margin: 20px 0; }
        .community-box { width: 80%; max-width: 800px; margin: 0 auto; background-color: #fff; border-radius: 10px; padding: 20px; box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1); }
        .post { border-bottom: 1px solid #ddd; padding: 15px 0; }
        .post:last-child { border-bottom: none; }
        .post h3 { margin: 0; color: #333; }
        .post p { color: #666; }
        .post-meta { font-size: 12px; color: #999; }
        .delete-btn { display: block; text-align: center; background-color: #ce1919; color: white; border: none; border-radius: 5px; font-size: 16px; cursor: pointer; }
        .delete-btn:hover { background-color: #b61717; }
        #post-form { display: none; width: 80%; max-width: 800px; margin: 10px auto; background-color: #fff; padding: 15px; border-radius: 10px; box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1); }
        #post-form input, #post-form textarea { width: 100%; padding: 10px; margin-top: 10px; border: 1px solid #ddd; border-radius: 5px; }
        #post-form button { width: 100%; padding: 10px; background-color: #19ce60; color: white; border: none; border-radius: 5px; font-size: 16px; cursor: pointer; margin-top: 10px; }
        #post-form button:hover { background-color: #17b655; }
        .back-btn { position: fixed; top: 15px; padding: 10px 20px; color: black; border: none; border-radius: 5px; text-decoration: none; font-weight: bold; cursor: pointer; }
        .comment-header { display: flex; justify-content: space-between; }
        .create-btn { display: block; width: 80%; max-width: 800px; margin: 20px auto; text-align: center; padding: 10px; background-color: #19ce60; color: white; border: none; border-radius: 5px; font-size: 16px; cursor: pointer; }
        .create-btn:hover { background-color: #17b655; }
    </style>
</head>
<body>
    <header>
        <div class="container">
            <h1 class="community-title"><spring:message code="community.title"/></h1>
        </div>
    </header>

    <div class="container">
        <main>
            <div class="community-box">
              <div class="post">
                <h2>${post.title}</h2>
                <p>${post.content}</p>
                <div class="post-meta">
                    <spring:message code="community.author"/>: ${post.author} |
                    <spring:message code="community.date"/>: ${post.createdAt}
                </div>
              </div>
            </div>

            <div class="community-box" style="margin-top: 60px">
              <h2><spring:message code="comment.section.title"/></h2>

              <c:forEach var="comment" items="${post.comments}">
                <div class="post">
                  <div class="comment-header">
                    <h3 id="comment-author-${comment.id}">${comment.author}</h3>
                    <form action="/project1/comment/delete" method="POST">
                      <input type="hidden" value="${comment.id}" name="id">
                      <input type="hidden" value="${post.id}" name="postId">
                      <button class="delete-btn" type="submit" style="width: 55px; height: 35px;">
                        <spring:message code="community.delete"/>
                      </button>
                    </form>
                  </div>
                  <p id="comment-content-${comment.id}">${comment.content}</p>
                  <div class="post-meta">
                    <spring:message code="community.date"/>: ${comment.createdAt}
                  </div>

                  <div class="post-actions">
                    <button class="translate-btn"
                            data-id="${comment.id}"
                            data-original-author="${comment.author}"
                            data-original-content="${comment.content}"
                            data-translated="false">
                      <spring:message code="community.translate"/>
                    </button>
                  </div>
                </div>
              </c:forEach>

              <div>
                <form action="/project1/comment/add" method="POST">
                  <div style="display: flex; flex-direction: column; margin-top: 15px;">
                    <input type="hidden" name="postId" value="${post.id}">
                    <input type="text" name="author" placeholder="<spring:message code='comment.author.input'/>" required style="width: 80px;">
                    <textarea name="content" placeholder="<spring:message code='comment.content.input'/>" required style="height: 150px;"></textarea>
                  </div>
                  <button class="create-btn" type="submit">
                    <spring:message code="community.submit"/>
                  </button>
                </form>
              </div>
            </div>
        </main>
    </div>

    <footer>
        <div class="container" align="center">
            <p>&copy; 2025 <spring:message code="community.footer"/></p>
        </div>
    </footer>
    
    <a href="http://www.team5.click/project1/community" class="back-btn">◀ <spring:message code="common.back"/></a>

    <!-- ✅ 스크립트는 맨 아래에 위치 -->
    <script>
    const MSG_TRANSLATE = "<spring:message code='community.translate'/>";
    const MSG_ORIGINAL = "<spring:message code='community.original'/>";
    const MSG_TRANSLATE_FAIL = "<spring:message code='community.translate.fail'/>";

    document.addEventListener('DOMContentLoaded', function () {
      const buttons = document.querySelectorAll('.translate-btn');

      buttons.forEach(button => {
        button.addEventListener('click', function () {
          const id = this.dataset.id;
          const authorEl = document.getElementById('comment-author-' + id);
          const contentEl = document.getElementById('comment-content-' + id);

          const isTranslated = this.dataset.translated === 'true';
          const originalAuthor = this.dataset.originalAuthor;
          const originalContent = this.dataset.originalContent;

          if (isTranslated) {
            authorEl.textContent = originalAuthor;
            contentEl.textContent = originalContent;
            this.textContent = MSG_TRANSLATE;
            this.dataset.translated = 'false';
          } else {
            fetch('/project1/api/translate/post', {
              method: 'POST',
              headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
              body: new URLSearchParams({
                title: originalAuthor,
                content: originalContent,
                direction: 'ko2ja'
              })
            })
            .then(res => res.json())
            .then(data => {
              authorEl.textContent = data.title;
              contentEl.textContent = data.content;
              this.textContent = MSG_ORIGINAL;
              this.dataset.translated = 'true';
            })
            .catch(err => {
              alert(MSG_TRANSLATE_FAIL);
              console.error(err);
            });
          }
        });
      });
    });
    </script>
</body>
</html>
