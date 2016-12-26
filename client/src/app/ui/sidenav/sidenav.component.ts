import { Component, OnInit } from '@angular/core';
import { AdminService } from '../../admin.service';

@Component({
  selector: 'app-sidenav',
  templateUrl: './sidenav.component.html',
  styleUrls: ['./sidenav.component.css'],
  providers: [AdminService]
})
export class SidenavComponent implements OnInit {

  constructor(private adminService: AdminService) { }

  ngOnInit() {
  }

  userSignedIn(): boolean {
    return this.adminService.userSignedIn();
  }

  signOut() {
    this.adminService.signOut();
  }

}
