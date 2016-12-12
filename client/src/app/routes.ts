import { RouterModule } from '@angular/router';
import { ModuleWithProviders } from '@angular/core';
import { MainComponent } from './containers/main.component'
import { EventListComponent } from './containers/event-list/event-list.component'
import { EventNewComponent } from './containers/event-new/event-new.component'


export const routes: ModuleWithProviders = RouterModule.forRoot([
  {
    path: '',
    component: MainComponent,
    children: [
      { path: '', component: EventListComponent },
      { path: 'events', component: EventListComponent },
      { path: 'new-event', component: EventNewComponent }
    ]
  },
  {
    path: '**', redirectTo: ''
  }
]);
