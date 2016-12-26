import { Injectable } from '@angular/core';
import { Router } from '@angular/router';
import { Angular2TokenService } from 'angular2-token';

@Injectable()
export class AdminService {
  constructor(private _tokenService: Angular2TokenService,
              private router: Router) {
    this._tokenService.init({
      signInPath:                 '/api/admins/sign_in',
      signOutPath:                '/api/admins/sign_out',
      validateTokenPath:          '/api/admins/validate_token',
      globalOptions: {
        headers: {
          'Content-Type':     'application/json',
          'Accept':           'application/json'
        }
      }
    });
  }

  userSignedIn(): boolean {
    return this._tokenService.userSignedIn();
  }

  signIn(email, password) {
    this._tokenService.signIn({
      email: email,
      password: password
    }).subscribe(
      res => {
        console.log(res);
        this.router.navigate(['']);
      },
      err => console.log(err)
    );
  }

  signOut() {
    this._tokenService.signOut().subscribe(res => this.router.navigate(['']));
  }
}
