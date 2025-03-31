<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><spring:message code="community.title"/></title>
    <script>
    const MSG_TRANSLATE = "<spring:message code='community.translate'/>";
    const MSG_ORIGINAL = "<spring:message code='community.original'/>";
    const MSG_TRANSLATE_FAIL = "<spring:message code='community.translate.fail'/>";

    function togglePostForm() {
        const form = document.getElementById("post-form");
        form.style.display = (form.style.display === "none" || form.style.display === "") ? "block" : "none";
    }

    document.addEventListener('DOMContentLoaded', function () {
        const buttons = document.querySelectorAll('.translate-btn');

        buttons.forEach(button => {
            button.addEventListener('click', function () {
                const id = this.dataset.id;
                const titleEl = document.getElementById('post-link-' + id);
                const contentEl = document.getElementById('post-content-' + id);

                const originalTitle = this.dataset.originalTitle || titleEl.textContent;
                const originalContent = this.dataset.originalContent || contentEl.textContent;
                const isTranslated = this.dataset.translated === 'true';

                if (isTranslated) {
                    titleEl.textContent = this.dataset.originalTitle;
                    contentEl.textContent = this.dataset.originalContent;
                    this.textContent = MSG_TRANSLATE;
                    this.dataset.translated = 'false';
                } else {
                    this.dataset.originalTitle = originalTitle;
                    this.dataset.originalContent = originalContent;

                    fetch('/project1/api/translate/post', {
                        method: 'POST',
                        headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
                        body: new URLSearchParams({
                            title: originalTitle,
                            content: originalContent,
                            direction: 'ko2ja'
                        })
                    })
                    .then(response => response.json())
                    .then(data => {
                        titleEl.textContent = data.title;
                        contentEl.textContent = data.content;
                        this.textContent = MSG_ORIGINAL;
                        this.dataset.translated = 'true';
                    })
                    .catch(err => {
                        console.error("❌ 번역 실패:", err);
                        alert(MSG_TRANSLATE_FAIL);
                    });
                }
            });
        });
    });
    </script>
    <style>
        .community-title { text-align: center; font-size: 2em; margin: 20px 0; }
        .community-box { width: 80%; max-width: 800px; margin: 0 auto; background: #fff; border-radius: 10px; padding: 20px; box-shadow: 0 2px 10px rgba(0,0,0,0.1); }
        .post { border-bottom: 1px solid #ddd; padding: 15px 0; display: flex; justify-content: space-between; align-items: center; }
        .post:last-child { border-bottom: none; }
        .post .info { flex: 1; }
        .post h3 { margin: 0; color: #333; }
        .post p { color: #666; }
        .post-meta { font-size: 12px; color: #999; }
        .post-actions { display: flex; flex-direction: column; gap: 5px; }
        .delete-btn { background-color: #ce1919; color: white; border: none; border-radius: 5px; font-size: 16px; cursor: pointer; }
        .delete-btn:hover { background-color: #b61717; }
        .create-post-btn { display: block; width: 80%; max-width: 800px; margin: 20px auto; text-align: center; padding: 10px; background-color: #19ce60; color: white; border: none; border-radius: 5px; font-size: 16px; cursor: pointer; }
        .create-post-btn:hover { background-color: #17b655; }
        #post-form { display: none; width: 80%; max-width: 800px; margin: 10px auto; background-color: #fff; padding: 15px; border-radius: 10px; box-shadow: 0 2px 5px rgba(0,0,0,0.1); }
        #post-form input, #post-form textarea { width: 100%; padding: 10px; margin-top: 10px; border: 1px solid #ddd; border-radius: 5px; }
        #post-form button { width: 100%; padding: 10px; background-color: #19ce60; color: white; border: none; border-radius: 5px; font-size: 16px; cursor: pointer; margin-top: 10px; }
        #post-form button:hover { background-color: #17b655; }
        .back-btn { position: fixed; top: 15px; padding: 10px 20px; color: black; border: none; border-radius: 5px; text-decoration: none; font-weight: bold; cursor: pointer; }
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
            <button class="create-post-btn" onclick="togglePostForm()">
                <spring:message code="community.createPost"/>
            </button>
            <div id="post-form">
                <form action="/project1/post/create" method="POST">
                    <input type="text" name="title" placeholder="<spring:message code='community.title.input'/>" required>
                    <textarea name="content" placeholder="<spring:message code='community.content.input'/>" required></textarea>
                    <button type="submit"><spring:message code="community.submit"/></button>
                </form>
            </div>

            <div class="community-box">
                <h2><spring:message code="community.postList"/></h2>
                <p>🔔 <spring:message code="community.postCount"/>: ${posts.size()}</p>

                <c:choose>
                    <c:when test="${not empty posts}">
                        <c:forEach var="post" items="${posts}">
                            <div class="post" id="post-${post.id}">
                                <div class="info">
                                    <h3>
                                        <a id="post-link-${post.id}" href="/project1/post/view?id=${post.id}">
                                            ${post.title}
                                        </a>
                                    </h3>
                                    <p id="post-content-${post.id}">${post.content}</p>
                                    <div class="post-meta">
                                        <spring:message code="community.author"/>: ${post.author} | 
                                        <spring:message code="community.date"/>: ${post.createdAt}
                                    </div>
                                    <button type="button" class="translate-btn" data-id="${post.id}">
                                        <spring:message code="community.translate"/>
                                    </button>
                                </div>
                                <div class="post-actions">
                                    <form action="/project1/post/delete" method="POST">
                                        <input type="hidden" name="id" value="${post.id}">
                                        <button class="delete-btn" type="submit" style="width: 55px; height: 35px;">
                                            <spring:message code="community.delete"/>
                                        </button>
                                    </form>
                                </div>
                            </div>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <p><spring:message code="community.empty"/></p>
                    </c:otherwise>
                </c:choose>
            </div>
        </main>
    </div>

    <footer>
        <div class="container" align="center">
            <p>&copy; 2025 <spring:message code="community.footer"/></p>
        </div>
    </footer>
    <a href="http://www.team5.click/project1/template" class="back-btn">◀ <spring:message code="common.back"/></a>
</body>
</html>
