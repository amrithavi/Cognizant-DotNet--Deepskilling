import { Component, EventEmitter, Input, OnChanges, Output, SimpleChanges } from '@angular/core';
import { CommonModule } from '@angular/common';
import { Highlight } from '../../directives/highlight';
import { CreditLabelPipe } from '../../pipes/credit-label-pipe';
import { EnrollmentService } from '../../services/enrollment';

@Component({
  selector: 'app-course-card',
  standalone: true,
  imports: [CommonModule, Highlight, CreditLabelPipe],
  templateUrl: './course-card.html',
  styleUrl: './course-card.css',
})
export class CourseCard implements OnChanges {

  constructor(private enrollmentService: EnrollmentService) {}

  @Input() course!: {
    id: number;
    name: string;
    code: string;
    credits: number;
    gradeStatus: 'passed' | 'failed' | 'pending';
  };

  @Output() enrollRequested = new EventEmitter<number>();

  isExpanded = false;

  ngOnChanges(changes: SimpleChanges): void {
    console.log('Course changed:', changes['course']);
  }

  enroll() {

  if (this.enrollmentService.isEnrolled(this.course.id)) {

    this.enrollmentService.unenroll(this.course.id);

  } else {

    this.enrollmentService.enroll(this.course.id);

  }

  this.enrollRequested.emit(this.course.id);

}

  get enrolled(): boolean {

  return this.enrollmentService.isEnrolled(this.course.id);

}

  toggleDetails() {
    this.isExpanded = !this.isExpanded;
  }

  get cardClasses() {
    return {
      'card--enrolled': false,
      'card--full': this.course.credits >= 4,
      expanded: this.isExpanded
    };
  }

  get borderColor() {
    switch (this.course.gradeStatus) {
      case 'passed':
        return 'green';
      case 'failed':
        return 'red';
      default:
        return 'grey';
    }
  }
}