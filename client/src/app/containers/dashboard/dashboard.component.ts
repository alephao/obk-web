import { Component, OnInit } from '@angular/core';
import {Http} from "@angular/http";

@Component({
  selector: 'app-dashboard',
  templateUrl: './dashboard.component.html',
  styleUrls: ['./dashboard.component.css']
})

export class DashboardComponent implements OnInit {
  info = {
    volunteers: 0,
    upcoming_events: 0,
    past_events: 0,
    volunteers_per_event: 0
  };

  constructor(private http: Http) { }

  ngOnInit() {
    this.http.get('/api/admin/dashboard/summary')
      .subscribe(
        data => {
          console.log(data);
          this.info = data.json();
        },
        err => console.log(err)
      );
  }
}
