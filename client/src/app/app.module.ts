import { BrowserModule } from '@angular/platform-browser';
import { NgModule } from '@angular/core';
import { FormsModule } from '@angular/forms';
import { HttpModule } from '@angular/http';

import { AppComponent } from './app.component';
import { EventListComponent } from './containers/event-list/event-list.component';
import { NavbarComponent } from './ui/navbar/navbar.component';
import { EventNewComponent } from './containers/event-new/event-new.component';
import { routes } from './routes';
import { MainComponent } from './containers/main.component';
import { SidenavComponent } from './ui/sidenav/sidenav.component';

@NgModule({
  declarations: [
    AppComponent,
    EventListComponent,
    NavbarComponent,
    EventNewComponent,
    MainComponent,
    SidenavComponent
  ],
  imports: [
    BrowserModule,
    FormsModule,
    HttpModule,
    routes
  ],
  providers: [],
  bootstrap: [AppComponent]
})
export class AppModule { }
