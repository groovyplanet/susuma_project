document.addEventListener("DOMContentLoaded", function () {
    const postLinks = document.querySelectorAll(".content-mix");

    postLinks.forEach(function (link) {
        link.addEventListener("click", function (event) {
            // event.preventDefault();

            const contentBox = this.closest('.content-box');
            const postContent = contentBox.querySelector(".post-content");
            if (postContent) {
                postContent.classList.toggle("open");
                let chevronDown = contentBox.querySelector(".bi-chevron-down");
                if (chevronDown) {
                    chevronDown.classList.remove("bi-chevron-down");
                    chevronDown.classList.add("bi-chevron-up");
                } else {
                    let chevronUp = contentBox.querySelector(".bi-chevron-up");
                    chevronUp.classList.remove("bi-chevron-up");
                    chevronUp.classList.add("bi-chevron-down");
                }
            }
        });
    });
});

