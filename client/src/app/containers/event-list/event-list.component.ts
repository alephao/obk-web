import { Component, OnInit } from '@angular/core';
import { Http } from '@angular/http';
// import { EventSearchPipe } from './event-search-pipe'

@Component({
  selector: 'app-event-list',
  templateUrl: './event-list.component.html',
  styleUrls: ['./event-list.component.css']
})

export class EventListComponent implements OnInit {
  events: Array<any>;

  constructor(private http: Http) { }

  ngOnInit() {
    this.http.get('/api/events.json')
      .subscribe(response => this.events = response.json().events);
  }

}
