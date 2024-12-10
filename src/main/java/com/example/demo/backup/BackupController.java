package com.example.demo.backup;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.example.demo.DbBackUp;
import com.example.demo.join.JoinDTO;


@Controller
public class BackupController {

    @Autowired
    private DbBackUp dbBackUp;
    
    @RequestMapping("/backupProc")
    public String backupProc(JoinDTO join) {
        dbBackUp.userFileUpload(join.getDbName());

        return "/main/mainform";
    }
    
}
