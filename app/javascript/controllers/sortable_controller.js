import { Controller } from "@hotwired/stimulus";
import Sortable from "sortablejs";
import { put } from "@rails/request.js";

export default class extends Controller {
  static values = { url: String };

  connect() {
    this.sortable = Sortable.create(this.element, {
      group: {
        name: "shared",
        put: true,
        pull: true
      },
      animation: 350,
      onEnd: this.onEnd.bind(this)
    });
    
  }

  disconnect() {
    this.sortable.destroy();
  }

  onEnd(event) {
    const { newStatus, item } = event;
    const url = item.dataset["sortableUrlValue"];
    console.log(url)
    const target_column = event.to.id; // Isso irá pegar o id da `<ul>` que recebeu o item
    put(url, {
      body: JSON.stringify({ status: target_column }),
    });
  }
}