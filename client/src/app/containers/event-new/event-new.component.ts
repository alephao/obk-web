import {
  Component,
  OnInit,
  Output,
  EventEmitter } from '@angular/core';
import {Http} from "@angular/http";
import { Router } from '@angular/router';


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
    start_date: "",
    end_date: ""
  };

  constructor(private http: Http, private router: Router) { }

  ngOnInit() {
  }

  createEvent() {
    const { title, description, start_date, end_date } = this.newEvent;

    if (title && description && start_date && end_date) {
      this.http.post("/api/admin/events", this.newEvent)
        //.map(res => res.json())
        .subscribe(
          data => console.log(data),
          err => console.log(err),
          () => this.router.navigate(['/events'])
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
      start_date: "",
      end_date: ""
    };
  }

}
