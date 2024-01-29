from sqlalchemy import create_engine, Column, Integer, String, ForeignKey
from sqlalchemy.orm import declarative_base, relationship, Session

sqlite_database = "sqlite:///metanit2.db"
engine = create_engine(sqlite_database)

Base = declarative_base()

class Student(Base):
    __tablename__ = "students"
    id = Column(Integer, primary_key=True, index=True)
    name = Column(String)
    courses = relationship("Course", back_populates="student")

class Course(Base):
    __tablename__ = "courses"
    id = Column(Integer, primary_key=True, index=True)
    name = Column(String)
    student_id = Column(Integer, ForeignKey("students.id"))
    student = relationship("Student", back_populates="courses")

with Session(autoflush=False, bind=engine) as db:
    kara = Student(name="Kara", courses=[Course(name="Фармакология"), Course(name="Управление и экономика фармации")])
    alina = Student(name="Alina", courses=[Course(name="Фармакология")])
    elaman = Student(name="Elaman", courses=[Course(name="Фармацевтическая химия")])

    db.add_all([kara, alina, elaman])
    db.commit()
