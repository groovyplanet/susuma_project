document.addEventListener("DOMContentLoaded", function() {
    const postLinks = document.querySelectorAll(".content-mix a");

    postLinks.forEach(function(link) {
        link.addEventListener("click", function(event) {
            // event.preventDefault();

            const contentBox = this.closest('.content-box');
            const postContent = contentBox.querySelector(".post-content");
            if (postContent) {
                postContent.classList.toggle("open");
            }
        });
    });
});

