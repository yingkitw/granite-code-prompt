import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';
import { catchError, map } from 'rxjs/operators';

interface User {
  id: number;
  name: string;
  email: string;
}

@Injectable({
  providedIn: 'root'
})
export class UserService {
  private apiUrl = 'https://api.example.com/users';

  constructor(private http: HttpClient) { }

  getUser(id: number): Observable<User> {
    return this.http.get<User>(`${this.apiUrl}/${id}`).pipe(
      map(user => ({ ...user, isLoaded: true })),
      catchError(this.handleError('getUser', []))
    );
  }

  private handleError<T>(operation = 'operation', result?: T) {
    return (error: any): Observable<T> => {
      console.error(error);
      return of(result as T);
    };
  }

  getUsers(): Observable<User[]> {
    return this.http.get<User[]>(this.apiUrl).pipe(
      map(users => users.map(user => ({ ...user, isLoaded: true }))),
      catchError(this.handleError('getUsers', []))
    );
  }

  createUser(user: User): Observable<User> {
    return this.http.post<User>(this.apiUrl, user).pipe(
      map(createdUser => ({ ...createdUser, isLoaded: true })),
      catchError(this.handleError('createUser', {}))
    );
  }

  updateUser(user: User): Observable<User> {
    const updatedUser = { ...user, isLoaded: true };
    return this.http.put<User>(`${this.apiUrl}/${user.id}`, updatedUser).pipe(
      map(updatedUser => ({ ...updatedUser, isLoaded: true })),
      catchError(this.handleError('updateUser', {}))
    );
  }

  deleteUser(id: number): Observable<void> {
    return this.http.delete<void>(`${this.apiUrl}/${id}`).pipe(
      catchError(this.handleError('deleteUser', void 0))
    );
  }
}