import { Routes, RouterModule } from '@angular/router';
import { ModuleWithProviders, NgModule} from '@angular/core';
import { MainComponent } from './containers/main.component';
import { EventListComponent } from './containers/event-list/event-list.component';
import { EventNewComponent } from './containers/event-new/event-new.component';
import { NewAdminSessionComponent } from './containers/new-admin-session/new-admin-session.component';
import { AuthGuard } from './auth-guard';
import { DashboardComponent } from "./containers/dashboard/dashboard.component";


const routes: Routes = [
  { path: 'sign-in', component: NewAdminSessionComponent },
  {
    path: '',
    component: MainComponent,
    canActivate: [AuthGuard],
    children: [
      { path: 'events', component: EventListComponent, data: { headerName: 'Events'} },
      { path: 'new-event', component: EventNewComponent, data: { headerName: 'New Event'} },
      { path: '', component: DashboardComponent, data: { headerName: 'Dashboard' } },
    ]
  },
  {
    path: '**', redirectTo: ''
  }
];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule],
  providers: []
})
export class HomeLibraryRoutingModule { }
