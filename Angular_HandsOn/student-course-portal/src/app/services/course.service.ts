import { Injectable } from '@angular/core';
import { Course } from '../models/course.model';

@Injectable({
  providedIn: 'root'
})
export class CourseService {

  constructor() {
    console.log('CourseService created');
  }

  private courses: Course[] = [];

  getCourses(): Course[] {
    return this.courses;
  }

}