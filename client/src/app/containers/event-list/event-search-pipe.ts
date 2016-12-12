import { Pipe } from '@angular/core';

@Pipe({
  name: 'EventSearchPipe'
})

export class EventSearchPipe {
  transform(value, args?) {
    let [query] = args;
    return value.filter(event => {
      return false; //event.title.indexOf(+query) != -1;
    });
  }
}
