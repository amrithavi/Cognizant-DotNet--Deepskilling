import { Component, signal } from '@angular/core';
import { Header } from './components/header/header';
import { Home } from './pages/home/home';
import { CourseList } from './pages/course-list/course-list';
import { RouterOutlet } from '@angular/router';

@Component({
  selector: 'app-root',
  imports: [RouterOutlet, Header, Home, CourseList],
  templateUrl: './app.html',
  styleUrl: './app.css'
})
export class App {
  protected readonly title = signal('student-course-portal');
}