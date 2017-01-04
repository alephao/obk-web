import { Component, OnInit } from '@angular/core';
import { AdminService } from '../../admin.service';

@Component({
  selector: 'app-navbar',
  templateUrl: './navbar.component.html',
  styleUrls: ['./navbar.component.css'],
  providers: [AdminService]
})

export class NavbarComponent implements OnInit {

  constructor(private adminService: AdminService) { }

  ngOnInit() {
  }

  signOut() {
    this.adminService.signOut();
  }
}
