import { TestBed } from '@angular/core/testing';
import { provideHttpClient } from '@angular/common/http';

import { EnrollmentService } from './enrollment';
import { CourseService } from './course.service';

describe('EnrollmentService', () => {

  let service: EnrollmentService;

  beforeEach(() => {

    TestBed.configureTestingModule({
      providers: [
        EnrollmentService,
        CourseService,
        provideHttpClient()
      ]
    });

    service = TestBed.inject(EnrollmentService);

  });

  it('should be created', () => {

    expect(service).toBeTruthy();

  });

});