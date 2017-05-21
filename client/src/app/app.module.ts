import { BrowserModule } from '@angular/platform-browser';
import { NgModule } from '@angular/core';
import { FormsModule } from '@angular/forms';
import { HttpModule } from '@angular/http';

import { Angular2TokenService } from 'angular2-token';

import { AppComponent } from './app.component';
import { DashboardComponent } from './containers/dashboard/dashboard.component';
import { EventListComponent } from './containers/event-list/event-list.component';
import { NavbarComponent } from './ui/navbar/navbar.component';
import { EventNewComponent } from './containers/event-new/event-new.component';
import { HomeLibraryRoutingModule } from './app-routing.module';
import { MainComponent } from './containers/main.component';
import { SidenavComponent } from './ui/sidenav/sidenav.component';
import { NewAdminSessionComponent } from './containers/new-admin-session/new-admin-session.component';
import { AuthGuard } from "./auth-guard";
import { HeaderNameComponent } from "./ui/header-name/header-name.component";
import { EventSearchPipe } from "./containers/event-list/event-search-pipe";

@NgModule({
  declarations: [
    AppComponent,
    DashboardComponent,
    EventListComponent,
    NavbarComponent,
    EventNewComponent,
    MainComponent,
    SidenavComponent,
    NewAdminSessionComponent,
    HeaderNameComponent,
    EventSearchPipe
  ],
  imports: [
    BrowserModule,
    FormsModule,
    HttpModule,
    HomeLibraryRoutingModule,
  ],
  providers: [
    Angular2TokenService,
    AuthGuard
  ],
  bootstrap: [
    AppComponent
  ]
})
export class AppModule { }
