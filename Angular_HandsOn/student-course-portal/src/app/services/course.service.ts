import { Injectable } from '@angular/core';
import { Course } from '../models/course.model';

@Injectable({
  providedIn: 'root'
})
export class CourseService {

  private courses: Course[] = [

    {
      id: 1,
      name: 'Angular',
      code: 'ANG101',
      credits: 4,
      gradeStatus: 'passed'
    },

    {
      id: 2,
      name: 'C#',
      code: 'CS102',
      credits: 3,
      gradeStatus: 'pending'
    },

    {
      id: 3,
      name: 'SQL',
      code: 'SQL103',
      credits: 2,
      gradeStatus: 'failed'
    },

    {
      id: 4,
      name: 'ASP.NET Core',
      code: 'ASP104',
      credits: 4,
      gradeStatus: 'passed'
    },

    {
      id: 5,
      name: 'JavaScript',
      code: 'JS105',
      credits: 3,
      gradeStatus: 'pending'
    }

  ];

  getCourses(): Course[] {

    return this.courses;

  }

  getCourseById(id: number): Course | undefined {

    return this.courses.find(c => c.id === id);

  }

  addCourse(course: Course): void {

    this.courses.push(course);

  }

}