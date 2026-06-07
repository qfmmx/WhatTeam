package com.example.supervisorbackend.util;

import java.time.LocalDate;

public final class AgeUtil {

    private AgeUtil() {
    }

    public static String ageToBirthday(Integer age) {
        if (age == null) {
            throw new IllegalArgumentException("年龄不能为空");
        }
        if (age < 0 || age > 150) {
            throw new IllegalArgumentException("年龄范围不合法");
        }
        return LocalDate.now().minusYears(age).withMonth(1).withDayOfMonth(1).toString();
    }

    public static Integer birthdayToAge(String birthday) {
        if (birthday == null || birthday.isBlank()) {
            return null;
        }
        return LocalDate.now().getYear() - LocalDate.parse(birthday).getYear();
    }
}
