# Prompting with IBM Granite 3 Model for Coding Use Cases

The experiment will be conducted using sample TypeScript code to demonstrate these capabilities.

```typescript
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
```

A few context variable

```python
model_id = GRANITE_3_8B_INSTRUCT
language = "typescript"
documentframework = "TypeDoc"
testframework = "Jest"
```

Initialise with watsonx.ai, please prepare your API_KEY and PROJECT_ID

```bash
pip install -U ibm-watsonx-ai
```

```python
from ibm_watsonx_ai.foundation_models import ModelInference
from ibm_watsonx_ai.metanames import GenTextParamsMetaNames as GenParams
import os
from dotenv import load_dotenv

load_dotenv()
api_key = os.getenv("API_KEY", None)
project_id = os.getenv("PROJECT_ID", None)

creds = {
    "url"    : "https://us-south.ml.cloud.ibm.com",
    "apikey" : api_key
}

params = {
    GenParams.DECODING_METHOD:"greedy",
    GenParams.MAX_NEW_TOKENS:4000,
    GenParams.MIN_NEW_TOKENS:1,
    # "temperature":0.1,
    GenParams.TOP_K:50,
    GenParams.TOP_P:1,
    GenParams.STOP_SEQUENCES:["```","[/INST]","<|user|>","<|endoftext|>","<|assistant|>"],
}

model = ModelInference(model_id="ibm/granite-3-8b-instruct", credentials=creds, params=params, project_id=project_id)
```

## Code Explanation

Understanding complex code segments is made easier with Granite 3 Model's detailed code explanations. It breaks down intricate code logic into comprehensible language, helping developers to grasp the functionality and purpose of different code sections. This feature is particularly useful for onboarding new team members, debugging, and maintaining large codebases where understanding legacy code is essential.

prompt for Explanation

```python
prompt = f"""<|user|>
Please provide a detailed explanation for the following {language} code:
-ensure have new line after every full stop.
-dont generate code.

###
code: `{sample_code}`
<|assistant|>
explanation:
"""

answer = model.generate_text(prompt)
print(answer)
```

output for explanation

```markdown

This TypeScript code defines an Angular service called `UserService` that handles CRUD (Create, Read, Update, Delete) operations for a `User` object. Here's a breakdown of the code:

1. **Imports**: The service imports necessary modules and interfaces from Angular and RxJS.

2. **User Interface**: An interface `User` is defined with properties `id`, `name`, and `email`.

3. **UserService**: The `UserService` is decorated with `@Injectable` to make it injectable as a service. It's provided at the root level, meaning it can be injected anywhere in the application.

4. **Constructor**: The constructor injects the `HttpClient` service, which is used to make HTTP requests.

5. **Methods**:

   - `getUser(id: number)`: This method retrieves a single user by their ID. It returns an observable that emits the user object with an additional `isLoaded` property set to `true`.

   - `getUsers()`: This method retrieves a list of all users. It returns an observable that emits an array of user objects with the `isLoaded` property set to `true`.

   - `createUser(user: User)`: This method creates a new user. It returns an observable that emits the created user object with the `isLoaded` property set to `true`.

   - `updateUser(user: User)`: This method updates an existing user. It returns an observable that emits the updated user object with the `isLoaded` property set to `true`.

   - `deleteUser(id: number)`: This method deletes a user by their ID. It returns an observable that emits `void` (nothing) upon successful deletion.

6. **Error Handling**: The `handleError` method is a private method that handles errors by logging them to the console and returning an observable that emits a default value.

7. **Operators**: The `map` operator is used to transform the response data, and the `catchError` operator is used to handle errors.

This service can be used in other components to perform CRUD operations on users.
```

## Automatic Documentation Generation

IBM Granite 3 Model automates the creation of comprehensive documentation for your codebase, eliminating the need for manual documentation efforts. By analyzing the code structure and functionality, it generates clear and detailed documentation that is essential for maintaining and scaling projects. This feature ensures that all aspects of the code are well-documented, making it easier for new developers to understand and contribute to the project.

prompt for document generation

```python
prompt = f"""<|user|>
generate {documentframework} document for the {language} provided.
-generate the {language} code only.
{language}: `{sample_code}`
-generate the document.
<|assistant|>
```{language}"""

answer = model.generate_text(prompt).replace("```","")
print(answer)
```

output for document generation

```typescript

/**
 * UserService provides methods for interacting with the user API.
 */
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

  /**
   * Gets a user by ID.
   * @param id The ID of the user to retrieve.
   * @returns An observable that emits the user data.
   */
  getUser(id: number): Observable<User> {
    return this.http.get<User>(`${this.apiUrl}/${id}`).pipe(
      map(user => ({ ...user, isLoaded: true })),
      catchError(this.handleError('getUser', []))
    );
  }

  /**
   * Gets a list of users.
   * @returns An observable that emits an array of user data.
   */
  getUsers(): Observable<User[]> {
    return this.http.get<User[]>(this.apiUrl).pipe(
      map(users => users.map(user => ({ ...user, isLoaded: true }))),
      catchError(this.handleError('getUsers', []))
    );
  }

  /**
   * Creates a new user.
   * @param user The user data to create.
   * @returns An observable that emits the created user data.
   */
  createUser(user: User): Observable<User> {
    return this.http.post<User>(this.apiUrl, user).pipe(
      map(createdUser => ({ ...createdUser, isLoaded: true })),
      catchError(this.handleError('createUser', {}))
    );
  }

  /**
   * Updates an existing user.
   * @param user The updated user data.
   * @returns An observable that emits the updated user data.
   */
  updateUser(user: User): Observable<User> {
    const updatedUser = { ...user, isLoaded: true };
    return this.http.put<User>(`${this.apiUrl}/${user.id}`, updatedUser).pipe(
      map(updatedUser => ({ ...updatedUser, isLoaded: true })),
      catchError(this.handleError('updateUser', {}))
    );
  }

  /**
   * Deletes a user.
   * @param id The ID of the user to delete.
   * @returns An observable that emits void when the deletion is complete.
   */
  deleteUser(id: number): Observable<void> {
    return this.http.delete<void>(`${this.apiUrl}/${id}`).pipe(
      catchError(this.handleError('deleteUser', void 0))
    );
  }

  /**
   * Handles errors for API requests.
   * @param operation The name of the operation that caused the error.
   * @param result The expected result of the operation.
   * @returns An observable that emits the result if no error occurred, or the provided result if an error occurred.
   */
  private handleError<T>(operation = 'operation', result?: T) {
    return (error: any): Observable<T> => {
      console.error(error);
      return of(result as T);
    };
  }
}
```

## Code Review and Scoring

Granite 3 Model offers automated code reviews that assess the quality of your code against industry standards. It provides scoring mechanisms that highlight areas of strength and identify potential issues, allowing developers to maintain high-quality codebases. This automated review process accelerates the feedback loop, enabling developers to make timely improvements and adhere to best practices without the need for extensive manual code inspections.

prompt for review and score

```python
prompt = f"""<|user|>
you are {language} expert. you need to review the following {language} code. 
-please understand the {language} code provided in detail.
-please review the code in completeness, logic, performance and quality.
-make it more object oriented.
-give a score out of 10 for the quality of code.
-please provide constructive suggestion in detail.
-generate the review and suggestion only.
{language} code: `{sample_code}`
-DONT generate the improve code directly.
-dont generate code.
<|assistant|>
score and review:"""

suggestion = model.generate_text(prompt)
print(suggestion)
```

outcome for review and score

```markdown


The provided TypeScript code is well-structured and follows best practices for Angular services. It uses Angular's HttpClient for making HTTP requests and employs RxJS operators for handling responses. The code is also object-oriented, with methods for getting, creating, updating, and deleting users.

However, there are a few areas for improvement:

1. Error handling: While the `handleError` method is used to handle errors, it might be better to throw a more specific error type instead of returning an empty observable. This would make it easier to handle errors in the components that use this service.

2. Type safety: The `createUser` and `updateUser` methods return an object with the `isLoaded` property set to `true`. However, this property is not defined in the `User` interface. It would be better to add this property to the interface or remove it from the returned object.

3. Code duplication: The `map` operator is used to add the `isLoaded` property to the response in several methods. This could be refactored into a separate method to avoid code duplication.

4. Documentation: While the code is generally easy to understand, adding JSDoc comments to explain the purpose of each method and its parameters would improve code readability and maintainability.

5. Type inference: In the `createUser` and `updateUser` methods, the type of the `user` parameter is explicitly defined as `User`. However, TypeScript can infer this type, so it's not necessary to include it.

6. Naming conventions: The `getUser` method could be renamed to `getUserById` to better reflect its purpose. Similarly, the `getUsers` method could be renamed to `getUsersList` or `getAllUsers`.

7. Error messages: The `handleError` method logs the error to the console but does not return a meaningful error message. It would be better to return a more descriptive error message or throw a custom error.

8. Type safety in `catchError`: The `catchError` operator is used with the `handleError` method, but the return type of `handleError` is not specified. This could lead to type errors. It would be better to specify the return type as `Observable<T>`.

9. Code consistency: The `deleteUser` method returns an `Observable<void>`, but the other methods return an `Observable<User>`. It would be better to maintain consistency in the return types.

10. Code organization: The `UserService` class could be organized into smaller, more focused classes or services. For example, the user-related operations could be moved to a separate `UserOperationsService`.

Overall, the code is well-written and follows good practices. With the suggested improvements, it could be even better.

Score: 8/10
```

## Enhancement Based on Reviews

Leveraging the feedback from automated code reviews, the Granite 3 Model facilitates continuous improvement of your codebase. It suggests specific enhancements to optimize performance, improve maintainability, and increase readability. By acting on these insights, developers can refine their code systematically, ensuring that the software remains robust and efficient as it evolves.

Prompt for improvement

```python
prompt = f"""<|user|>
improve the {language} provided base on the review provided.
-understand the review suggestion in detail.
-adopt the review suggestion if applicable.
-dont generate explanation.
###
original {language} code: `{sample_code}`
review suggestion: `{suggestion}`
<|assistant|>
improved {language}
```{language}"""

answer = model.generate_text(prompt).replace("```","")
print(answer)
```

Output for improvement

```typescript

import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';
import { catchError, map, throwError } from 'rxjs/operators';

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

  getUserById(id: number): Observable<User> {
    return this.http.get<User>(`${this.apiUrl}/${id}`).pipe(
      map(user => ({ ...user, isLoaded: true })),
      catchError(this.handleError<User>('getUserById', []))
    );
  }

  getUsersList(): Observable<User[]> {
    return this.http.get<User[]>(this.apiUrl).pipe(
      map(users => users.map(user => ({ ...user, isLoaded: true }))),
      catchError(this.handleError<User[]>('getUsersList', []))
    );
  }

  createUser(user: User): Observable<User> {
    return this.http.post<User>(this.apiUrl, user).pipe(
      map(createdUser => ({ ...createdUser, isLoaded: true })),
      catchError(this.handleError<User>('createUser', {}))
    );
  }

  updateUser(user: User): Observable<User> {
    const updatedUser = { ...user, isLoaded: true };
    return this.http.put<User>(`${this.apiUrl}/${user.id}`, updatedUser).pipe(
      map(updatedUser => ({ ...updatedUser, isLoaded: true })),
      catchError(this.handleError<User>('updateUser', {}))
    );
  }

  deleteUser(id: number): Observable<void> {
    return this.http.delete<void>(`${this.apiUrl}/${id}`).pipe(
      catchError(this.handleError<void>('deleteUser', void 0))
    );
  }

  private handleError<T>(operation = 'operation', result?: T) {
    return (error: any): Observable<T> => {
      console.error(error);
      throwError(new Error(`An error occurred while ${operation}: ${error.message}`));
    };
  }
}
```

## Error Identification and Fixing

The Granite 3 Model excels at identifying and rectifying errors in your code. It efficiently locates potential syntax errors andlogical flaws. By analyzing the code, it proposes fixes and improvements, offering developers an initial draft to consider. This feature streamlines the debugging process, enabling developers to focus on verification and testing, ensuring robust code.

Problem Code

```typescript
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
    return this.http.get<ded: true })),
      catchError(this.handleError('getUser', []))
    );
  }

  private handleError<T>(operation = 'operation', result?: T) {
    return (error: any): Observable<T> => {
      console.error(error);
      return of(result as T);
    };
  }r[]>(this.apiUrl).pipe(
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
    return this.http.put<Us
  }

  deleteUser(id: number): Observable<void> {
    return this.http.delete<void>(`${this.apiUrl}/${id}`).pipe(
      catchError(this.handleError('deleteUser', void 0))
    );
  }
}
```

Prompt for Fixing

```python
prompt = f"""<|user|>
fix the {language} provided.
-understand the review suggestion in detail.
-identify if any problem.
-fix the problem if any.
-add explanation as inline comment.

###
{language}: `{bad_code}`
<|assistant|>
fixed version with inline comment at the point it fix.
```{language}"""

answer = model.generate_text(prompt).replace("```","")
print(answer)
```

Output for Fixing

```typescript

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
    return this.http.put<User>(`${this.apiUrl}/${user.id}`, user).pipe(
      map(() => user),
      catchError(this.handleError('updateUser', user))
    );
  }

  deleteUser(id: number): Observable<void> {
    return this.http.delete<void>(`${this.apiUrl}/${id}`).pipe(
      catchError(this.handleError('deleteUser', void 0))
    );
  }
}
```

## Diagram Generation

Understanding complex code structures is made easier with Granite 3 Model's diagram generation capabilities. It automatically creates visual representations of your code architecture, including class diagrams and flowcharts. These diagrams enhance comprehension and improve communication on projects with intricate dependencies.

Prompt for Generate Diagram

```python
prompt = f"""<|user|>
generate diagram for the {language} code provided.
-understand the review suggestion in detail.
-use simple name for node.
-generate in mermaid.
-dont repeating.
-dont generation explanation.
{language}: `{sample_code}`
<|assistant|>
```mermaid"""

answer = model.generate_text(prompt).replace("```","")
print(answer)
```

Output for Generate Diagram

```mermaid

graph TD
A[UserService] --> B[getUser(id: number): Observable<User>]
A --> C[getUsers(): Observable<User[]>]
A --> D[createUser(user: User): Observable<User>]
A --> E[updateUser(user: User): Observable<User>]
A --> F[deleteUser(id: number): Observable<void>]
B --> G[http.get<User>(`${this.apiUrl}/${id}`)]
C --> H[http.get<User[]>(this.apiUrl)]
D --> I[http.post<User>(this.apiUrl, user)]
E --> J[http.put<User>(`${this.apiUrl}/${user.id}`, updatedUser)]
F --> K[http.delete<void>(`${this.apiUrl}/${id}`)]
G --> L[map(user => ({ ...user, isLoaded: true }))]
H --> M[map(users => users.map(user => ({ ...user, isLoaded: true })))]
I --> N[map(createdUser => ({ ...createdUser, isLoaded: true }))]
J --> O[map(updatedUser => ({ ...updatedUser, isLoaded: true }))]
K --> P[catchError(this.handleError('deleteUser', void 0))]
L --> Q[catchError(this.handleError('getUser', []))]
M --> R[catchError(this.handleError('getUsers', []))]
N --> S[catchError(this.handleError('createUser', {}))]
O --> T[catchError(this.handleError('updateUser', {}))]

```

## Code Conversion

Granite 3 Model seamlessly converts code between different programming languages or formats, enhancing compatibility and facilitating cross-platform development. Whether migrating legacy systems to modern languages or adapting code for different environments, this feature ensures that the transition is smooth and error-free. It can supports a wide range of languages, making it a versatile tool for diverse development needs.

Prompt for conversion

```python
target_language = "golang"

prompt = f"""<|user|>
rewrite the {language} code provided to {target_language}.
-understand the code provided in detail.
-understand how to map technology and syntax to the target {target_language} langauge.
-dont generation explanation.
{language}: `{sample_code}`
<|assistant|>
```{target_language}"""

answer = model.generate_text(prompt).replace("```","")
print(answer)
```

Output for conversion

```typescript

package main

import (
	"net/http"

	"github.com/tidwall/gjson"
)

type User struct {
	ID    int    `json:"id"`
	Name  string `json:"name"`
	Email string `json:"email"`
}

type UserService struct {
	apiUrl string
}

func NewUserService(apiUrl string) *UserService {
	return &UserService{apiUrl: apiUrl}
}

func (us *UserService) GetUser(id int) (*User, error) {
	resp, err := http.Get(us.apiUrl + "/" + strconv.Itoa(id))
	if err != nil {
		return nil, err
	}
	defer resp.Body.Close()

	var user User
	err = gjson.Get(resp.Body, "#.id,#.name,#.email").Scan(&user)
	if err != nil {
		return nil, err
	}

	user.IsLoaded = true
	return &user, nil
}

func (us *UserService) GetUsers() ([]*User, error) {
	resp, err := http.Get(us.apiUrl)
	if err != nil {
		return nil, err
	}
	defer resp.Body.Close()

	var users []User
	err = gjson.Get(resp.Body, "#").Array().Each(&users, func(i int, v gjson.Result) bool {
		user := User{}
		err = v.Get("id").Int(&user.ID)
		if err != nil {
			return false
		}
		err = v.Get("name").String(&user.Name)
		if err != nil {
			return false
		}
		err = v.Get("email").String(&user.Email)
		if err != nil {
			return false
		}
		user.IsLoaded = true
		users[i] = user
		return true
	})
	if err != nil {
		return nil, err
	}

	return users, nil
}

func (us *UserService) CreateUser(user User) error {
	resp, err := http.Post(us.apiUrl, "application/json", nil, user)
	if err != nil {
		return err
	}
	defer resp.Body.Close()

	var createdUser User
	err = gjson.Get(resp.Body, "#.id,#.name,#.email").Scan(&createdUser)
	if err != nil {
		return err
	}

	createdUser.IsLoaded = true
	return nil
}

func (us *UserService) UpdateUser(user User) error {
	resp, err := http.Put(us.apiUrl + "/" + strconv.Itoa(user.ID), "application/json", nil, user)
	if err != nil {
		return err
	}
	defer resp.Body.Close()

	var updatedUser User
	err = gjson.Get(resp.Body, "#.id,#.name,#.email").Scan(&updatedUser)
	if err != nil {
		return err
	}

	updatedUser.IsLoaded = true
	return nil
}

func (us *UserService) DeleteUser(id int) error {
	resp, err := http.Delete(us.apiUrl + "/" + strconv.Itoa(id))
	if err != nil {
		return err
	}
	defer resp.Body.Close()

	return nil
}
```

## API Generation

Automating the creation of APIs, Granite 3 Model accelerates the integration of your codebase with external systems. It generates well-structured and documented APIs based on your existing code, facilitating seamless communication and data exchange between different software components. This feature is particularly beneficial for developing scalable and interoperable applications that require robust API interfaces.

Prompt for API Generation

```python
prompt = f"""<|user|>
generate a API definition in swagger for the {language} code provided.
-dont generate explanation.
{language}: `{sample_code}`
<|assistant|>
```yaml
"""

answer = model.generate_text(prompt).replace("```","")
print(answer)
```

Output for API Generation

```yaml
openapi: 3.0.0
info:
  title: UserService API
  version: 1.0.0
servers:
  - url: https://api.example.com/users
paths:
  /{id}:
    get:
      summary: Get a user by ID
      parameters:
        - name: id
          in: path
          required: true
          schema:
            type: integer
            format: int64
      responses:
        '200':
          description: A user object
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/User'
    post:
      summary: Create a new user
      requestBody:
        required: true
        content:
          application/json:
            schema:
              $ref: '#/components/schemas/User'
      responses:
        '201':
          description: The created user object
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/User'
  /:
    get:
      summary: Get a list of users
      responses:
        '200':
          description: A list of user objects
          content:
            application/json:
              schema:
                type: array
                items:
                  $ref: '#/components/schemas/User'
    post:
      summary: Update an existing user
      requestBody:
        required: true
        content:
          application/json:
            schema:
              $ref: '#/components/schemas/User'
      responses:
        '200':
          description: The updated user object
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/User'
  /{id}:
    delete:
      summary: Delete a user by ID
      parameters:
        - name: id
          in: path
          required: true
          schema:
            type: integer
            format: int64
      responses:
        '204':
          description: No content
components:
  schemas:
    User:
      type: object
      properties:
        id:
          type: integer
          format: int64
        name:
          type: string
        email:
          type: string
        isLoaded:
          type: boolean
```

## Test Case Generation

Ensuring thorough testing is essential for reliable software development. Granite 3 Model automatically generates relevant test cases for your code, covering various scenarios and edge cases. This acceleration of the testing phase helps in identifying potential issues early, ensuring that the code performs as expected and meets the required quality standards before deployment.

Prompt for Test Case

```python
prompt = f"""<|user|>
generate Test Cases in {testframework} for the {language} code provided.
-focus on boundary cases.
-focus on exception handling
-generate the test only.
{language}: `{sample_code}`
<|assistant|>
```{language}"""

answer = model.generate_text(prompt).replace("```","")
print(answer)
```

Output for Test Case

```typescript

import { TestBed } from '@angular/core/testing';
import { HttpClientTestingModule, HttpTestingController } from '@angular/common/http/testing';
import { UserService } from './user.service';
import { User } from './user.model';

describe('UserService', () => {
  let service: UserService;
  let httpMock: HttpTestingController;

  beforeEach(() => {
    TestBed.configureTestingModule({
      imports: [HttpClientTestingModule],
      providers: [UserService]
    });
    service = TestBed.inject(UserService);
    httpMock = TestBed.inject(HttpTestingController);
  });

  afterEach(() => {
    httpMock.verify();
  });

  it('should get user by id', () => {
    const mockUser: User = { id: 1, name: 'John Doe', email: 'john.doe@example.com' };
    service.getUser(1).subscribe(user => expect(user).toEqual(mockUser));

    const req = httpMock.expectOne(`${service.apiUrl}/1`);
    expect(req.request.method).toBe('GET');
    req.flush(mockUser);
  });

  it('should get users', () => {
    const mockUsers: User[] = [
      { id: 1, name: 'John Doe', email: 'john.doe@example.com' },
      { id: 2, name: 'Jane Doe', email: 'jane.doe@example.com' }
    ];
    service.getUsers().subscribe(users => expect(users).toEqual(mockUsers));

    const req = httpMock.expectOne(service.apiUrl);
    expect(req.request.method).toBe('GET');
    req.flush(mockUsers);
  });

  it('should create user', () => {
    const mockUser: User = { id: 3, name: 'New User', email: 'new.user@example.com' };
    service.createUser(mockUser).subscribe(user => expect(user).toEqual(mockUser));

    const req = httpMock.expectOne(service.apiUrl, { method: 'POST' });
    expect(req.request.body).toEqual(mockUser);
    req.flush(mockUser);
  });

  it('should update user', () => {
    const mockUser: User = { id: 1, name: 'Updated User', email: 'updated.user@example.com' };
    service.updateUser(mockUser).subscribe(user => expect(user).toEqual(mockUser));

    const req = httpMock.expectOne(`${service.apiUrl}/1`, { method: 'PUT' });
    expect(req.request.body).toEqual({ ...mockUser, isLoaded: true });
    req.flush(mockUser);
  });

  it('should delete user', () => {
    service.deleteUser(1).subscribe(() => {
      const req = httpMock.expectOne(`${service.apiUrl}/1`);
      expect(req.request.method).toBe('DELETE');
      req.flush(null);
    });
  });

  it('should handle error when getting user', () => {
    service.getUser(1).subscribe(
      user => expect(user).toBeNull(),
      error => expect(error).toEqual('Error getting user')
    );

    const req = httpMock.expectOne(`${service.apiUrl}/1`);
    req.error(new Error('Error getting user'));
  });

  it('should handle error when getting users', () => {
    service.getUsers().subscribe(
      users => expect(users).toBeNull(),
      error => expect(error).toEqual('Error getting users')
    );

    const req = httpMock.expectOne(service.apiUrl);
    req.error(new Error('Error getting users'));
  });

  it('should handle error when creating user', () => {
    service.createUser({ id: 1, name: 'New User', email: 'new.user@example.com' }).subscribe(
      user => expect(user).toBeNull(),
      error => expect(error).toEqual('Error creating user')
    );

    const req = httpMock.expectOne(service.apiUrl, { method: 'POST' });
    req.error(new Error('Error creating user'));
  });

  it('should handle error when updating user', () => {
    service.updateUser({ id: 1, name: 'Updated User', email: 'updated.user@example.com' }).subscribe(
      user => expect(user).toBeNull(),
      error => expect(error).toEqual('Error updating user')
    );

    const req = httpMock.expectOne(`${service.apiUrl}/1`, { method: 'PUT' });
    req.error(new Error('Error updating user'));
  });

  it('should handle error when deleting user', () => {
    service.deleteUser(1).subscribe(
      () => expect(true).toBeFalse(),
      error => expect(error).toEqual('Error deleting user')
    );

    const req = httpMock.expectOne(`${service.apiUrl}/1`);
    req.error(new Error('Error deleting user'));
  });
});
```
