import { Component, OnInit } from '@angular/core';
import { ActivatedRoute, Router, NavigationEnd } from '@angular/router';
import 'rxjs/add/operator/filter';

@Component({
  selector: 'app-header-name',
  templateUrl: './header-name.component.html',
  styleUrls: ['./header-name.component.css']
})
export class HeaderNameComponent implements OnInit {
  headerName: string;

  constructor(private route: ActivatedRoute, private router: Router) { }

  ngOnInit() {
    this.router.events
      .filter(event => event instanceof NavigationEnd)
      .subscribe(e => {
        let currentRoute = this.route.root;

        while (currentRoute.children[0] !== undefined) {
          currentRoute = currentRoute.children[0];
        }

        this.headerName = currentRoute.snapshot.data['headerName'];
      });
  }
}
