import { Component } from '@angular/core';
import { AdminService } from './admin.service'

@Component({
  selector: 'app-root',
  templateUrl: './app.component.html',
  styleUrls: ['./app.component.css'],
  providers: [AdminService]
})
export class AppComponent {
  title = 'app works!';

  constructor(private adminService: AdminService) { }
}
