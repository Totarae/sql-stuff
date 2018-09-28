   FUNCTION f_get_yandex_api(p_link VARCHAR2) RETURN VARCHAR2 IS
      v_url     VARCHAR2(4000) := 'https://clck.ru/--?url=$TARGET$';
      request   utl_http.req;
      response  utl_http.resp;
      n         NUMBER;
      buff      VARCHAR2(4000);
      clob_buff CLOB;
   BEGIN
      v_url := REPLACE(v_url, '$TARGET$', p_link);
      utl_http.set_wallet('file:/directory/home/oracle/admin/db/wallet_address', 'password'); --If you need to
      utl_http.set_response_error_check(FALSE);
      request := utl_http.begin_request(v_url, 'GET');
      response := utl_http.get_response(request);
      /*DBMS_OUTPUT.PUT_LINE('HTTP response status code: ' || response.status_code);*/
      IF response.status_code = 200 THEN
         BEGIN
            clob_buff := empty_clob;
            LOOP
               utl_http.read_text(response, buff, length(buff));
               /*dbms_output.put_line(buff);*/
               clob_buff := clob_buff || buff;
            END LOOP;
            utl_http.end_response(response);
            v_url:=clob_buff;
         EXCEPTION
            WHEN utl_http.end_of_body THEN
               utl_http.end_response(response);
            WHEN OTHERS THEN
               dbms_output.put_line(SQLERRM);
               dbms_output.put_line(dbms_utility.format_error_backtrace);
               utl_http.end_response(response);
         END;
      ELSE
         dbms_output.put_line('ERROR');
         utl_http.end_response(response);
      END IF;
      
      return v_url;
   END;