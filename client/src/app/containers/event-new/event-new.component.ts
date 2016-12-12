import {
  Component,
  OnInit,
  Output,
  EventEmitter } from '@angular/core';
import {Http} from "@angular/http";

@Component({
  selector: 'app-event-new',
  templateUrl: './event-new.component.html',
  styleUrls: ['./event-new.component.css']
})
export class EventNewComponent implements OnInit {
  // @Output() createEvent = new EventEmitter();

  newEvent = {
    title: "",
    description: "",
    start: "",
    end: ""
  };

  createEvent() {
    const { title, description, start, end } = this.newEvent;

    if (title && description && start && end) {
      this.http.post("http://localhost:3000/api/events", this.newEvent)
        //.map(res => res.json())
        .subscribe(
          data => console.log(data),
          err => console.log(err),
          () => console.log("Tey")
        );
      // this.reset();
    } else {
      alert("Fill the form");
    }
  }

  reset() {
    this.newEvent = {
      title: "",
      description: "",
      start: "",
      end: ""
    };
  }

  constructor(public http: Http) {

  }

  ngOnInit() {
  }

}
