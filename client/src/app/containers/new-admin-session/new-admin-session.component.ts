import { Component, OnInit } from '@angular/core';
// import { Angular2TokenService } from 'angular2-token';
import { AdminService } from '../../admin.service';

@Component({
  selector: 'app-new-admin-session',
  templateUrl: './new-admin-session.component.html',
  styleUrls: ['./new-admin-session.component.css'],
  providers: [AdminService]
})
export class NewAdminSessionComponent implements OnInit {

  credentials: {email: string, password: string} = {
    email: '',
    password: ''
  };

  constructor(private adminService: AdminService) { }

  ngOnInit() {
  }

  signIn() {
    this.adminService.signIn(
      this.credentials.email,
      this.credentials.password
    );
  }
}
