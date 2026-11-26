package com.example.demo.entity;

import jakarta.persistence.*;
import lombok.*;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Entity
@Table(name = "Users")
public class User {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @Column(unique = true, nullable = false, length = 50)
    private String username;

    @Column(nullable = false)
    private String password;

    @Column(columnDefinition = "nvarchar(100)")
    private String fullname;

    @Column(unique = true, length = 100)
    private String email;

    // 1: Admin, 0: User thường
    private Integer roleId = 0; 
}