/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controladores;

/**
 *
 * @author nmohamed
 */


import java.io.FileReader;
import java.io.IOException;
import java.io.Reader;
import java.sql.*;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.logging.Logger;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import javax.servlet.http.HttpSession;

import org.springframework.context.ApplicationContext;
import org.springframework.jdbc.datasource.DriverManagerDataSource;
import org.springframework.stereotype.Controller;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.context.support.WebApplicationContextUtils;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.multiaction.MultiActionController;

@RequestMapping("/")
public class Homepage extends MultiActionController{

    Connection cn;

    private Object getBean(String nombrebean, ServletContext servlet) {
        ApplicationContext contexto = WebApplicationContextUtils.getRequiredWebApplicationContext(servlet);
        Object beanobject = contexto.getBean(nombrebean);
        return beanobject;
    }

    public ModelAndView inicio(HttpServletRequest hsr, HttpServletResponse hsr1) throws Exception {
        return new ModelAndView("userform");
    }

    @RequestMapping
    public ModelAndView login(HttpServletRequest hsr, HttpServletResponse hsr1) throws Exception {
        //  DBConect.close();

        //DBCPDataSource testC22 = new DBCPDataSource(2);
        // c = new DBConect(hsr, hsr1, "TEST", "95.216.37.137", "david", "david", 21);
        // DBCPDataSource.getInstance();
//        HttpSession session = hsr.getSession();
//        //  String schoolCode = "AH";
//
//   
//        // Connection con_ah = DBCPDataSource.getConnection_ah();
//
//        Statement stAux = null;
//        ResultSet rs = null;
//        session.setAttribute("yearsids", new Gson().toJson(this.getYears(BambooConfig.schoolCode)));
//        session.setAttribute("schoolCode", BambooConfig.schoolCode);
////        User user = new User();
////        LoginVerification login = new LoginVerification();


        /************************ Comentado facturacion **************
         * ModelAndView mv = new ModelAndView("clientesView");
         ***********************************************
         */

            ModelAndView mv = new ModelAndView("menuView");
////        String message = "Username or Password incorrect";
////
////        try {
////            if ("QuickBook".equals(hsr.getParameter("txtusuario"))) {
////                mv = new ModelAndView("redirect:/suhomepage.htm?opcion=loadconfig");
////                return mv;
////            } else {
////                user = login.consultUserDB(hsr.getParameter("txtusuario"), hsr.getParameter("txtpassword"));
////            }
////            if (user.getId() == 0) {
////                mv = new ModelAndView("userform");
////                message = "Username or password incorrect";
////                mv.addObject("message", message);
////                return mv;
////            } else {
////                ArrayList<String> arrayGroupIds = login.fromGroupNames(user.getId());
////                if (arrayGroupIds.contains("MontessoriHead")) {
////                    user.setType(2);
////                } else if (arrayGroupIds.contains("MontessoriAdmin")) {
////                    user.setType(0);
////                } else if (arrayGroupIds.contains("MontessoriTeacher")) {
////                    user.setType(1);
////                } else {
////                    user.setType(-1);
////                }
////
////                PoolC3P0_RenWeb pool = PoolC3P0_RenWeb.getInstance();
////                Connection c_ah = pool.getConnection();
////                stAux = c_ah.createStatement();
////                if (user.getType() != -1) {
////                    mv = new ModelAndView("redirect:/homepage/loadLessons.htm");
////                    message = "welcome user";
////                    int termId = 1, yearId = 1;
////                    rs = stAux.executeQuery("select defaultyearid,defaulttermid from ConfigSchool where SchoolCode ='" + BambooConfig.schoolCode + "'");
////                    // ResultSet rs2 = DBConect.ah.executeQuery("select defaultyearid,defaulttermid from ConfigSchool where  SchoolCode ='" + schoolCode + "'");
////                    while (rs.next()) {
////                        termId = rs.getInt("defaulttermid");
////                        yearId = rs.getInt("defaultyearid");
////                    }
////                    session.setAttribute("user", user);
////                    session.setAttribute("termId", termId);
////                    session.setAttribute("yearId", yearId);
////
////                    String nameTerm = "", nameYear = "";
////                    rs = stAux.executeQuery("select name from SchoolTerm where TermID = " + termId + " and YearID = " + yearId);
////                    //  ResultSet rs3 = DBConect.ah.executeQuery("select name from SchoolTerm where TermID = " + termId + " and YearID = " + yearId);
////                    while (rs.next()) {
////                        nameTerm = "" + rs.getString("name");
////                    }
////                    rs = stAux.executeQuery("select SchoolYear from SchoolYear where yearID = " + yearId);
////                    // ResultSet rs4 = DBConect.ah.executeQuery("select SchoolYear from SchoolYear where yearID = " + yearId);
////                    while (rs.next()) {
////                        nameYear = "" + rs.getString("SchoolYear");
////                    }
////                    session.setAttribute("termYearName", nameTerm + " / " + nameYear);
////                    mv.addObject("message", message);
////
////                } else {
////                    mv = new ModelAndView("userform");
////                    message = "Username or Password incorrect";
////                    mv.addObject("message", message);
////                }
////                c_ah.close();
////            }
////        } catch (Exception e) {
////            System.err.println("");
////        }/* finally {
//            try {
//                if (rs != null) {
//                    rs.close();
//                }
//            } catch (Exception e) {
//            }
//            try {
//                if (stAux != null) {
//                    stAux.close();
//                }
//            } catch (Exception e) {
//            }
//            try {
//                if (con_ah != null) {
//                    con_ah.close();
//                }
//            } catch (Exception e) {
//            }
//        }
//         */
        return mv;
   }



//    @RequestMapping("/keepAlive.htm")
//    @ResponseBody
//    public String keepAlive(HttpServletRequest hsr, HttpServletResponse hsr1) {
//
//        if ((new SessionCheck()).checkSession(hsr)) {
//            return "ERROR";
//        } else {
//
//            return "OK";
//        }
//    }
    
 

}
