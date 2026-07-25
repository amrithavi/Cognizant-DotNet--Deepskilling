import { Component } from '@angular/core';
import { CommonModule } from '@angular/common';
import { CourseCard } from '../../components/course-card/course-card';

@Component({
  selector: 'app-course-list',
  standalone: true,
  imports: [CommonModule, CourseCard],
  templateUrl: './course-list.html',
  styleUrl: './course-list.css',
})
export class CourseList {

  courses = [
  {
    id: 1,
    name: 'Angular',
    code: 'ANG101',
    credits: 4
  },
  {
    id: 2,
    name: 'C#',
    code: 'CS102',
    credits: 3
  },
  {
    id: 3,
    name: 'SQL',
    code: 'SQL103',
    credits: 2
  },
  {
    id: 4,
    name: 'ASP.NET Core',
    code: 'ASP104',
    credits: 4
  },
  {
    id: 5,
    name: 'JavaScript',
    code: 'JS105',
    credits: 3
  }
];

selectedCourseId: number | null = null;

onEnroll(courseId: number) {
  console.log('Enrolling in course: ' + courseId);
  this.selectedCourseId = courseId;
}

}