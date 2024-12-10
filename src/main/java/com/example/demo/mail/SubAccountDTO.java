package com.example.demo.mail;

public class SubAccountDTO { // 부계정을 담아서 list로 출력할 dto
    private String subAccountId;
    private String ePw;

    public SubAccountDTO(String subAccountId, String ePw) {
        this.subAccountId = subAccountId;
        this.ePw = ePw;
    }

    public String getSubAccountId() {
        return subAccountId;
    }

    public String getEPw() {
        return ePw;
    }
}
