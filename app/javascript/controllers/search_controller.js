document.addEventListener("turbo:load", () => {
  const searchInput = document.getElementById("search-input");
  const tasksContainer = document.getElementById("tasks-container");

  if (searchInput) {
    searchInput.addEventListener("input", function () {
      const searchTerm = this.value.toLowerCase();

      const tasks = tasksContainer.querySelectorAll(".task-card");

      tasks.forEach((task) => {
        const title = task.getAttribute("task-title").toLowerCase();
        const priority = task.getAttribute("task-priority").toLowerCase();
        if (title.includes(searchTerm) || priority.includes(searchTerm)) {
          task.style.display = "block";
        } else {
          task.style.display = "none";
        }
      });
    });
  }
});
