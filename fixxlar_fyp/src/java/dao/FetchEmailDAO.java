/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

import java.util.*;
import javax.mail.*;
import entity.Email;
import org.apache.commons.lang3.ArrayUtils;
/**
 *
 * @author Joshymantou
 */
public class FetchEmailDAO {
    
    /**
     *
     * @return
     */
    public Message[] fetchEmail() {
        Properties props = new Properties();
        props.setProperty("mail.store.protocol", "imaps");
        //store inbox emails as Message object, store all into Message[] array.
        Message[] msgArr = null;
        try {
            Session session = Session.getInstance(props, null);
            Store store = session.getStore();
            store.connect("imap-mail.outlook.com", "joshymantou@outlook.com", "mcgrady11");
            Folder inbox = store.getFolder("INBOX");
            inbox.open(Folder.READ_ONLY);
            msgArr = inbox.getMessages();

            //System.out.println(msgArr.length);
            /*for (int i = 0; i < msgArr.length; i++) {
                Message msg = msgArr[i];
                Address[] in = msg.getFrom();
                for (Address address : in) {
                    System.out.println("FROM:" + address.toString());
                }
                
                Multipart mp = (Multipart) msg.getContent();
                BodyPart bp = mp.getBodyPart(0);
                /*
                System.out.println("SENT DATE:" + msg.getSentDate());
                System.out.println("SUBJECT:" + msg.getSubject());
                System.out.println("CONTENT:" + bp.getContent());
                
            }*/
            ArrayUtils.reverse(msgArr);
            return msgArr;
        } catch (Exception mex) {
            mex.printStackTrace();
        }
        return msgArr;
    }
}
