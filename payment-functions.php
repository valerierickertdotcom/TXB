<?php

/**********************************************************************************
*  CREATED BY: VALERIE RICKERT, CCP
*              ValerieRickert.com
*  DATE:       January 2019
***********************************************************************************
*
*  Add userid to created-by and sysdate to created-date
*  Set userid to updated-by and sysdate to created-date when record updated;
*  Use trigger to update that information. 
*
* These functions are used for payments.
*
* Will query OrderPayment table to see if orderid has been entered into
* the table already.If not, add it; otherwise, update data with latest payment
* information.
*
* Also need to query OrderPayment table to retrieve 
* OrderPaymentCurrentTotal and OrderPaymentCreditCardFees so that these
* fields can be updated.
*
* If OrderID does not exist in table, then retrieve total $ value of order (hidden
* field in form).
*
* New Record will be added to OrderPayment table containing OrderPaymentID, 
* OrderID, OrderTotal (which you will have as hidden on form), 
* OrderPaymentCurrentTotal (calculated), and OrderPaymentCreditCardFees (calculated).
*
* Count if OrderID exists in OrderPaymentDetail table.  IF so, increment count and add
* additional payment information.
*
* Perform check of payment amount to make sure total paid does not go over the total
* amount of order.  Notify user if it does.
*
************************************************************************************/

    function CheckPaymentValidity($paymentData)
    {
        // check to see if $orderid exists in OrderPayments (Header) table
        // make sure $result does not exist in $con global variables
        
        global $con;
        $configs = array();
        $paymentOrderID = "";
        
        $paymentType          =  $paymentData['$paymentmethodid'];
        $paymentOrderID       =  $paymentData['$orderid'];
        
        /* retrieving payment amount from $paymentData array */
        
        if($paymentType === "Cash") {
            $paymentAmount = $paymentData['$cashamount'];
        }
        else if($paymentType === "Check") {
            $paymentAmount = $paymentData['$checkamount'];
        }
        else if($paymentType === "Credit Card") {
            $paymentAmount = $paymentData['$creditcardamount'];
        } /* end of processing of $paymentType */
        
        /* retrieving orderid payment information from OrderPayment table */
        
        $sql = "SELECT OrderID
        ,OrderTotal
        ,CurrentTotalPaid
        ,CreditCardFees
        FROM OrderPayment
        WHERE OrderPayment.OrderID = '".$paymentOrderID."'
        ";
        
        $result = mysqli_query($con, $sql);
        
        if ($result === false) { /* error occurred in mySQL */
            echo('CheckPaymentValidity on OrderID failed: ' . mysqli_error($con));
            exit;
        }
        else if (mysqli_num_rows($result) === 0) {
            return true;
        }
        else {
            /* data exists */
            
            while($row = mysqli_fetch_array( $result )) {
                $configs[] = $row;
            }
            
            /* check if CurrentTotalPaid + $payment amount > $total_price final.  */
            /* if it is, return false for payment validity; they must enter another payment amount. */
            
            foreach ($configs as $config) {
                $paymentCurrentTotal = $config['CurrentTotalPaid'];
                $totalOrderPrice = $config['OrderTotal'];
            }
            
            $paymentTotal = $paymentCurrentTotal + $paymentAmount;
            
            /* Order Total in Order Payment table should equal $totalpricefinal in $paymentArray */
            
            return ($paymentTotal < $totalOrderPrice);
            
        } /* data exists */
        
    } /* end of CheckPaymentValidity Function */
    
    function getpaymentsingle($orderid)
    {
        // check to see if $orderid exists in OrderPayments (Header) table
        // make sure $result does not exist in $con global variables
        
        global $con;
        $configs = array();
        
        $sql = "SELECT OrderID
        ,OrderTotal
        ,CurrentTotalPaid
        ,CreditCardFees
        FROM OrderPayment
        WHERE OrderPayment.OrderID = '".$orderid."'
        ";
        
        $result = mysqli_query($con, $sql);
        
        if ($result === false) { /* error occurred in mySQL */
            echo('GetPaymentSingle on OrderID failed: ' . mysqli_error($con));
            exit;
        }
        else if (mysqli_num_rows($result) === 0) {
            /* do nothing */
        }
        else {
            /* data exists */
            
            while($row = mysqli_fetch_array( $result )) {
                $configs[] = $row;
            }
            
        }
        return $configs;
        
    }   // end getpaymentsingle function
    
    
    function getOrderPaymentDetailLine($orderid)
    {
        /*
         ** Check to see if $orderid exists in OrderPaymentDetail (Detail) table
         ** and return count of lines
         **
         ** make sure $result does not exist in $con global variables
         */
        
        global $con;
        
        $sql = "SELECT COUNT(OrderID) as total
        FROM OrderPaymentDetail
        WHERE OrderPaymentDetail.OrderID = '".$orderid."'
        ";
        
        $result = mysqli_query($con, $sql);
        
        if ($result === false) { /* error occurred in mySQL */
            echo('GetOrderPaymentDetailLine on OrderID failed: ' . mysqli_error($con));
            exit;
        }
        else { /* retrieval successful - may be zero or more */
            /* do nothing other than echo */
        }
        
        return $result;
        
    }  // end getOrderPaymentDetailLine
  
    function makePaymentAdd($paymentData) {
        
        /************************************************
         ****        INSERT, EDIT OR DELETE           ****
         ************************************************/
        
        /*
         ** Begin payment processing; add header info first
         **
         ** Set the following beforehand:
         **
         ** The createdBy, createdDate fields will be updated
         ** via trigger when new records are added to OrderPayment table.
         **
         ** The updatedBy and updatedDate fields
         ** will be updated via trigger when the OrderPayment and
         ** OrderPaymentDetail tables are updated.
         **
         ** createdBy
         ** createdDate
         ** updatedBy
         ** updatedDate
         */
        
        global $con;
        
 //       print_r($paymentData);
        
        /*  Initialize variables: paymentPrevTotal, paymentCurrentTotal, paymentCreditCardFees,
         **             paymentPrevCreditCardFees, and creditCardFees
         */
        
        $paymentPrevTotal = 0;
        $paymentCurrentTotal = 0;
        $paymentCreditCardFees = 0;
        $paymentPrevCreditCardFees = 0;
        $creditCardFees = 0;
        
        // Creating datetime for Payment Header and Detail; this may not be necessary; can use date or sysdate.
        
        $datetime = new DateTime();
        $dateadded = $datetime->format('Y\-m\-d\ h:i:s');
        $dateyearonly = $datetime->format('Y\-m\-d');
        
        $lastRecordedDate = $datetime->format('Y\-m\-d\ h:i:s');
        $lastRecordedBy = $_SESSION['userid']; /* this code will only be appropriate for TXB server, not localhost */
        
        $createdDate = $datetime->format('Y\-m\-d\ h:i:s');
        $createdBy = $_SESSION['userid']; /* this code will only be appropriate for TXB server, not localhost */
        
        /*
        ** Now Process form info
        ** Retrieve data from $paymentData array; change the below layout.
        */
        
        $orderid              =  $paymentData['$orderid'];
        $trailerPrice         =  $paymentData['$totalpricefinal'];
        $paymentType          =  $paymentData['$paymentmethodid'];
        
        $checkNumber          =  $paymentData['$checknumber'] ?? '';
        $checkDate            =  $paymentData['$checkdate'] ?? '';
        if ($checkDate === '') {
            /* do nothing */
        }
        else {
            $checkDate = date('Y-m-d',strtotime($checkDate));
        }
        $checkName            =  $paymentData['$checkname'] ?? '';
        $checkAccountNumber   =  $paymentData['$checkaccountnumber'] ?? '';
        $checkRoutingNumber   =  $paymentData['$checkroutingnumber'] ?? '';
        
        $creditCardType       =  $paymentData['$creditcardtype'] ?? '';
        $creditCardName       =  $paymentData['$creditcardname'] ?? '';
        $creditCardNumber     =  $paymentData['$creditcardnumber'] ?? '';
        $creditCardExpiration =  $paymentData['$creditcardexpiration'] ?? '';
        $creditCardCVC        =  $paymentData['$creditcardcvc'] ?? '';
        
        if($paymentType === "Cash") {
            
            $paymentAmount = $paymentData['$cashamount'];
            $paymentDate   = date('Y-m-d',strtotime($paymentData['$cashpaymentdate']));  // date('Y-m-d', strtotime($_POST[Date]))
  
        }
        else if($paymentType === "Check") {
           
            $paymentAmount = $paymentData['$checkamount'];
            $paymentDate   = date('Y-m-d',strtotime($paymentData['$checkdate']));
 
        }
        else if($paymentType === "Credit Card") {
 
            $paymentAmount = $paymentData['$creditcardamount'];
            $paymentDate   = date('Y-m-d',strtotime($paymentData['$creditcarddate']));
            $paymentCreditCardFee = ($paymentAmount * 0.0325) + 0.25;  // today's fee - 3.25% + 0.25 per transaction fee

        } /* end of processing of $paymentType */
        else { /* do nothing */
  //          echo '<p>There\'s an issue with $paymentType which is currently set at '.$paymentType.'</p>';
        }
        
        /***********************************************************************************
         ** Now check if OrderPayment entry for $orderid already exists.  If so, update data,
         ** else add row to OrderPayment table for $orderid.
         ***********************************************************************************/
        
        $configs = getpaymentsingle($orderid);
        
        if ((!$configs) || count($configs)==0) {
            
            /**********************************************************************************
             ** If num of rows contained in $configs array is 0, then records do not exist in
             ** OrderPayment table for $orderid, so add it!
             ** Set up creditCardFees and paymentCurrentTotal as well.
             **********************************************************************************/
            
            $creditCardFees = $paymentCreditCardFee;  /* since this is first record, only current data is added. */
            $paymentCurrentTotal = $paymentAmount;
            
            /*************************************************************************************
             ** Insert into OrderPayment include sthe autoincrement field of OrderPaymentID
             ** as MySQL will add that increment automatically when NULL is specified.  Also
             ** depends upon settings in table definition.  Primary key MUST BE auto-increment.
             ** Also specifying IGNORE as MySQL has strict settings.
             **************************************************************************************/
            
            $sqlAddOrderPaymentHeader =
            "
            INSERT IGNORE INTO OrderPayment (OrderPaymentID
                                             ,OrderID
                                             ,OrderTotal
                                             ,CurrentTotalPaid
                                             ,CreditCardFees
                                             )
            VALUES (NULL
                    ,'".$orderid."'
                    ,'".$trailerPrice."'
                    ,'".$paymentCurrentTotal."'
                    ,'".$creditCardFees."'
                    )
            ";
            
            // save copy of $sqlAddOrderPaymentHeader into $sql and run $sql for error catching
            
            $sql = $sqlAddOrderPaymentHeader;
            
            if (!mysqli_query($con, $sql)) {
                echo'<p>Insert into OrderPayment table for OrderID failed: ' . mysqli_error($con).'</p>';
                exit;
            }
            else { /* do nothing; update successful */
                //echo '<p>Insert of orderid into OrderPayment table is successful!</p>';
            }
            
        } /* end of Insert operation for OrderPayment table entry for $orderid */
        
        else {
            
            /**************************************************************************************
             ** OrderPayment table entry for orderid already exists so update values.
             **
             **************************************************************************************/
            
            if ($configs === false) {
            //    echo "<p>Odd sentence.  If this happens, investigate.<br><br>**There are no matching items</p>";
            }
            else {
                //echo '<p>Retrieving current orderid OrderPayment table info for update.  Should be only one row of data.</p>';
                foreach ($configs as $config) {
                    $paymentPrevTotal = $config['CurrentTotalPaid'];
                    $paymentPrevCreditCardFees = $config['CreditCardFees'];
                }
            } /* end of retrieving current OrderPayment table information for existing $orderid entry */
            
            $creditCardFees     = $paymentPrevCreditCardFees + $paymentCreditCardFee;  /* cumulative credit card fees */
            $paymentCurrentTotal = $paymentPrevTotal + $paymentAmount;
            
            //echo '<p>Performing update of OrderPayment table with current payment total info. </p>';
            $sqlUpdateOrderPaymentHeader =
            "
            UPDATE OrderPayment
            SET CurrentTotalPaid   = '".$paymentCurrentTotal."'
            ,CreditCardFees    = '".$creditCardFees."'
            WHERE OrderPayment.OrderID = '".$orderid."'
            ";
            
            $sql = $sqlUpdateOrderPaymentHeader;
            
            if (!mysqli_query($con, $sql)) {
                echo('Update of OrderPayment table for OrderID failed: ' . mysqli_error($con));
                exit;
            }
            
        }  /* end of Update OrderPayment table entry for $orderid processing */
        
        /***************************************************************************************************************
         ** Next, add detail line to OrderPaymentDetail Table
         ** Retrieve count of detail lines and increment; this number will become PaymentDetailLineNumber
         ** in PaymentDetailLineNumber table
         ***************************************************************************************************************/
        
        $result = getOrderPaymentDetailLine($orderid);
        $countObj = mysqli_fetch_assoc($result);
        $count = $countObj['total'];
        
        $count = $count + 1;
        
        /***************************************************************************************************************
         **
         ** Now insert detail data about payment for order into OrderPaymentDetail table.
         **
         ** The Insert into OrderPaymentDetail WILL include the autoincrement field of
         ** OrderPaymentDetailID even though MySQL will add that value automatically (primary key)
         **
         ***************************************************************************************************************/
        
        //echo '<p>Retrieval successful.  Adding current payment info to OrderPaymentDetail table. </p>';
        $sqlAddOrderPaymentDetail =
        "
        INSERT IGNORE INTO OrderPaymentDetail (
                                               OrderPaymentDetailID
                                               ,OrderID
                                               ,PaymentDetailLineNumber
                                               ,PaymentType
                                               ,PaymentDate
                                               ,PaymentAmount
                                               ,CheckNumber
                                               ,CheckDate
                                               ,CheckAccountNumber
                                               ,CheckRoutingNumber
                                               ,CheckName
                                               ,CreditCardType
                                               ,CreditCardName
                                               ,CreditCardNumber
                                               ,CreditCardExpiration
                                               ,CreditCardCVC
                                               ,CreditCardFee    )
        VALUES (
                NULL
                ,'".$orderid."'
                ,'".$count."'
                ,'".$paymentType."'
                ,'".$paymentDate."'
                ,'".$paymentAmount."'
                ,'".$checkNumber."'
                ,'".$checkDate."'
                ,'".$checkAccountNumber."'
                ,'".$checkRoutingNumber."'
                ,'".$checkName."'
                ,'".$creditCardType."'
                ,'".$creditCardName."'
                ,'".$creditCardNumber."'
                ,'".$creditCardExpiration."'
                ,'".$creditCardCVC."'
                ,'".$paymentCreditCardFee."'
                )
        ";
        
        $sql = $sqlAddOrderPaymentDetail;
        
        if (!mysqli_query($con, $sql)) {
            echo('Insert into OrderPaymentDetail table for OrderID failed: ' . mysqli_error($con));
            exit;
        }
        
        /***************************************************************************************************************
         ** NOTE: Triggers OrderPaymentDetail.insertUserTriggerAI and OrderPaymentDetail.updateUserTriggerAU
         **       will set the userid and date of the person who inserted and and/or updated the OrderPaymentDetails table.
         **
         ****************************************************************************************************************
         **
         ** Check placement of bracket and parentheses
         **
         ****************************************************************************************************************
         **
         ** Now send note to page and email to thank for payment; This is for later when on the TXB Server.
         **
         ***************************************************************************************************************/
        
    } /* end of function makePaymentAdd */
    
    // function to add form data into an array that will then be passed to addpayment process
    
    function prepareArray() {
        
        // reference the variables to be added to array
        
        global $paymentmethodid, $checknumber, $checkdate, $checkamount, $checkaccountnumber,  $checkroutingnumber;
        global $creditcardtype, $creditcardname, $creditcardnumber, $creditcardcvc,  $creditcardexpiration, $creditcarddate, $creditcardamount;
        global $cashamount, $cashpaymentdate;
        global $total_pricefinal, $orderid;
        
        // initialize array
        $paymentArray = array();
        
        $paymentArray['$orderid'] = $orderid;
        $paymentArray['$totalpricefinal'] = $total_pricefinal;
        
        if ($paymentmethodid == 'Cash') {
            $paymentArray['$paymentmethodid'] = 'Cash';
            $paymentArray['$cashamount'] = $cashamount;
            $paymentArray['$cashpaymentdate'] = $cashpaymentdate;
        }
        else if ($paymentmethodid == 'Check') {
            $paymentArray['$paymentmethodid'] = 'Check';
            $paymentArray['$checknumber'] = $checknumber;
            $paymentArray['$checkdate'] = $checkdate;
            $paymentArray['$checkamount'] = $checkamount;
            $paymentArray['$checkaccountnumber'] = $checkaccountnumber;
            $paymentArray['$checkroutingnumber'] = $checkroutingnumber;
        }
        else if ($paymentmethodid == 'Credit Card') {
            $paymentArray['$paymentmethodid'] = 'Credit Card';
            $paymentArray['$creditcardtype'] = $creditcardtype;
            $paymentArray['$creditcardname'] = $creditcardname;
            $paymentArray['$creditcardnumber'] = $creditcardnumber;
            $paymentArray['$creditcardcvc'] = $creditcardcvc;
            $paymentArray['$creditcardexpiration'] = $creditcardexpiration;
            $paymentArray['$creditcarddate'] = $creditcarddate;
            $paymentArray['$creditcardamount'] = $creditcardamount;
        }
        
 //       echo '<p>Getting ready to return paymentArray.  Printing out array contents:</p>';
 //       print_r($paymentArray);
        
        return $paymentArray;
        
    } /* end of function prepareArray() */
    
    //
    // another function to manually clear the form on the php side after it has been submitted
    // and when validation is taking place.
    //
    
    function resetForm($form) {
        $form.find('input:text, select, textarea').val('');
        
    }
    
    // clear_form function resets the form as well as the php variables associated with it.
    
    function clear_form() {
        
        // reference the variables to be cleared
        global $paymentmethodid, $checknumber, $checkdate, $checkamount, $checkaccountnumber,  $checkroutingnumber;
        global $creditcardtype, $creditcardname, $creditcardnumber, $creditcardcvc,  $creditcardexpiration, $creditcarddate, $creditcardamount;
        global $cashamount, $cashpaymentdate;
        //global $msg_success;
        
        global $checkRoutingNumberErr, $checkRoutingNumberErr2;
        global $creditCardTypeErr, $creditCardNameErr, $creditCardNameErr2, $creditCardNumberErr,  $creditCardNumberErr2;
        global $creditCardExpirationErr, $creditCardExpirationErr2, $creditCardExpirationErr3,  $creditCardCVCErr, $creditCardCVCErr2;
        global $creditCardDateErr, $creditCardDateErr2, $creditCardDateErr3, $creditCardDateErr4,  $creditCardAmountErr, $creditCardAmountErr2, $creditCardAmountErr3;
        global $cashAmountErr, $cashAmountErr2, $cashAmountErr3, $cashPaymentDateErr, $cashPaymentDateErr2,  $cashPaymentDateErr3, $cashPaymentDateErr4;
        
        // clear the variables
        $checkRoutingNumberErr = $checkRoutingNumberErr2 = "";
        $creditCardTypeErr = $creditCardNameErr = $creditCardNameErr2 = $creditCardNumberErr = $creditCardNumberErr2 = "";
        $creditCardExpirationErr = $creditCardExpirationErr2 = $creditCardExpirationErr3 = $creditCardCVCErr = $creditCardCVCErr2 = "";
        $creditCardDateErr = $creditCardDateErr2 = $creditCardDateErr3 = $creditCardDateErr4 = $creditCardAmountErr = $creditCardAmountErr2 = $creditCardAmountErr3 = "";
        $cashAmountErr = $cashAmountErr2 = $cashAmountErr3 = $cashPaymentDateErr = $cashPaymentDateErr2 = $cashPaymentDateErr3 = $cashPaymentDateErr4 = "";
        
        $paymentmethodid = $checknumber = $checkdate = $checkamount = $checkaccountnumber = $checkroutingnumber = "";
        $creditcardtype = $creditcardname = $creditcardnumber = $creditcardcvc =  $creditcardexpiration = $creditcarddate = $creditcardamount = "";
        $cashamount = $cashpaymentdate = "";
        //$msg_success = "";
        
        // call reset to clear form
        
        $_POST = array();
        //       resetForm($('#paymentform'));
        echo '<script type="text/javascript">$("#paymentform")[0].reset();</script>';
        
    }  /* end of clear_form function */
    
    // declare a function to strip input of hacked characters; I forgot this!
    
    function test_input($data) {
        $data = trim($data);
        $data = stripslashes($data);
        $data = htmlspecialchars($data);
        return $data;
    }
    
    function validateFeedbackForm($arr) {
        
        // declare the global variables for scoping
        global $paymentmethodid, $checknumber, $checkdate, $checkamount, $checkaccountnumber, $checkroutingnumber;
        global $creditcardtype, $creditcardname, $creditcardnumber, $creditcardcvc, $creditcardexpiration, $creditcarddate, $creditcardamount;
        global $cashamount, $cashpaymentdate;
        
        //decare error message global as well
        
        global $paymentMethodIDErr, $checkNumberErr, $checkNumberErr2, $checkDateErr, $checkDateErr2, $checkDateErr3;
        global $checkAmountErr, $checkAmountErr2, $checkAmountErr3, $checkAccountNumberErr, $checkAccountNumberErr2;
        global $checkRoutingNumberErr, $checkRoutingNumberErr2;
        global $creditCardTypeErr, $creditCardNameErr, $creditCardNameErr2, $creditCardNumberErr, $creditCardNumberErr2;
        global $creditCardExpirationErr, $creditCardExpirationErr2, $creditCardExpirationErr3, $creditCardCVCErr, $creditCardCVCErr2;
        global $creditCardDateErr, $creditCardDateErr2, $creditCardDateErr3, $creditCardDateErr4, $creditCardAmountErr, $creditCardAmountErr2, $creditCardAmountErr3;
        global $cashAmountErr, $cashAmountErr2, $cashAmountErr3, $cashPaymentDateErr, $cashPaymentDateErr2, $cashPaymentDateErr3, $cashPaymentDateErr4;
        
        global $msg_success, $orderid, $total_pricefinal;
        
        // initialize some variables for now
        
        $msg_success = "";
        //   $orderid = 234;
        //   $total_pricefinal = 23405;
        
        if(isset($_POST['submit'])) {
            // call form handler
            // msg_success if not being set correctly after initial completed validation so
            // reiniailizing the msg_success variable here.
            //
            $msg_success = "";
            
            // checking payment method
            if(empty($_POST['paymentmethodid'])) {
                $paymentMethodIDErr = "Please choose a payment method.";
            }
            else {
                $paymentmethodid = test_input($_POST['paymentmethodid']);;
            }
            
            if(isset($paymentmethodid) && ($paymentmethodid == "Check")) {
                
                // checking check number
                if(empty($_POST['checknumber'])) {
                    $checkNumberErr = "Please enter a check number.";
                }
                else {
                    $checknumber = test_input($_POST['checknumber']);
                    $checknumber_pattern = '/^[0-9]*$/';
                    if (preg_match($checknumber_pattern,$checknumber)) {
                        // do nothing - match was found so valid
                    }
                    else {
                        $checkNumberErr2 = "Only numbers are allowed in the check number. Please try again.";
                    }
                }
                
                // checking date of the check
                if(empty($_POST['checkdate'])) {
                    $checkDateErr = "Please enter the date on the check.";
                }
                else {
                    $checkdate = test_input($_POST['checkdate']);
                    $date_array = explode("/",$checkdate);
                    // break out date;
                    $day = $date_array[1];
                    $month = $date_array[0];
                    $year = $date_array[2];
                    
                    if(!checkdate($month,$day,$year)) {
                        $checkDateErr2 = "Your date must be in mm/dd/yy format. Please try again.";
                    }
                    else {
                        $today = date("m/d/Y");
                        $strToday = strtotime($today);
                        $enteredDate = strtotime($checkdate);
                        if($enteredDate < $strToday) {
                            $checkDateErr3 = "Date supplied is before present day. Please adjust.";
                        }
                    }
                }
                
                // verifying check amount
                if(empty($_POST['checkamount'])) {
                    $checkAmountErr = "Please enter the amount of the check.";
                }
                else {
                    $checkamount = test_input($_POST['checkamount']);
                    $checkamount_pattern = '/^[0-9]+.[0-9][0-9]*$/';
                    preg_match($checkamount_pattern,$checkamount,$checkamount_match);
                    if(!$checkamount_match[0]) {
                        $checkAmountErr2 = "Check amount must be numeric. Please try again.";
                    }
                    else if (($checkamount == 0) || ($checkamount > 50000)) {
                        $checkAmountErr3 = "Check amount must be greater than 0 and less than $50K.";
                    }
                }
                
                // verifying check account number
                if(empty($_POST['checkaccountnumber'])) {
                    $checkAccountNumberErr = "Please enter your checking account number.";
                }
                else {
                    $checkaccountnumber = test_input($_POST['checkaccountnumber']);
                    $checkaccountnumber_pattern = '/^[0-9]*$/';
                    preg_match($checkaccountnumber_pattern,$checkaccountnumber,$checkaccountnumber_matches);
                    if(!$checkaccountnumber_matches[0]) {
                        $checkAccountNumberErr2 = "Only numbers are allowed in the check account number. Please try again.";
                    }
                }
                
                // verifying check routing number
                if(empty($_POST['checkroutingnumber'])) {
                    $checkRoutingNumberErr = "Please enter your checking routing number.";
                }
                else {
                    $checkroutingnumber = test_input($_POST['checkroutingnumber']);
                    $checkroutingnumber_pattern = '/^[0-9]*$/';
                    preg_match($checkroutingnumber_pattern,$checkroutingnumber,$checkroutingnumber_matches);
                    if(!$checkroutingnumber_matches[0]) {
                        $checkRoutingNumberErr2 = "Only numbers are allowed in the check routing number. Please try again.";
                    }
                }
            } /* End of if payment method type = 'Check' */
            else if(isset($paymentmethodid) && ($paymentmethodid == "Credit Card")) {
                
                // verifying credit card type
                if(empty($_POST['creditcardtype'])) {
                    $creditCardTypeErr = "Please select your credit card.";
                }
                else {
                    $creditcardtype = test_input($_POST['creditcardtype']);
                }
                
                // verifying credit card name
                if(empty($_POST['creditcardname'])) {
                    $creditCardNameErr = "Please enter the name on the credit card.";
                }
                else {
                    $creditcardname = $_POST['creditcardname'];
                    $creditcardname_pattern = '/^[a-zA-Z ]*$/';
                    preg_match($creditcardname_pattern,$creditcardname,$creditcardname_match);
                    if(!$creditcardname_match[0]) {
                        $creditCardNameErr2 = "Name on Credit Card must be contains letters or whitespace. Please adjust.";
                    }
                }
                
                // verifying credit card number
                if(empty($_POST['creditcardnumber'])) {
                    $creditCardNumberErr = "Please enter the credit card number.";
                }
                else {
                    $creditcardnumber = test_input($_POST['creditcardnumber']);
                    $creditcardnumber_pattern = '/^[0-9]{4} [0-9]{4} [0-9]{4} [0-9]{4}$/';
                    if (preg_match($creditcardnumber_pattern,$creditcardnumber)) {
                        // do nothing - match was found so valid
                    }
                    else {
                        $creditCardNumberErr2 = "Only numbers and whitespace are allowed for the credit card number. Please enter as 'xxxx xxxx xxxx xxxx', including spaces.";
                    }
                }
                
                // verifying credit card expiration
                if(empty($_POST['creditcardexpiration'])) {
                    $creditCardExpirationErr = "Please enter the Expiration Month/Year on the credit card.";
                }
                else {
                    $creditcardexpiration = test_input($_POST['creditcardexpiration']);
                    $date_array = explode("/",$creditcardexpiration);
                    // break out date;
                    //$day = $date_array[1];
                    $month = $date_array[0];
                    $year = $date_array[1];
                    
                    if($year < date("y")) { // can also use 'y' for a two digit year
                        $creditCardExpirationErr2 = "The Expiration year is less than the current year. Please try again.";
                    }
                    else if (($month < date("m")) && ($year = date("y"))) {
                        $creditCardExpirationErr3 = "Please check Expiration date.  You specified an expired date.";
                    }
                    else {
                        // do nothing; all good.
                    }
                }
                
                // verifying CVC on credit card
                if(empty($_POST['creditcardcvc'])) {
                    $creditCardCVCErr = "Please enter the security code (CVC) from the back of the credit card.";
                }
                else {
                    $creditcardcvc = test_input($_POST['creditcardcvc']);
                    $creditcardcvc_pattern = '/^[0-9]{3}$/';
                    preg_match($creditcardcvc_pattern,$creditcardcvc,$creditcardcvc_matches);
                    if(!$creditcardcvc_matches[0]) {
                        $creditCardCVCErr2 = "Three digits are required for the security code (CVC). Please try again.";
                    }
                }
                
                // verifying date for credit card payment
                if(empty($_POST['creditcarddate'])) {
                    $creditCardDateErr = "Please enter the date on the credit card payment.";
                }
                else {
                    $creditcarddate = test_input($_POST['creditcarddate']);
                    $cd_date_array = explode("/",$creditcarddate);
                    // break out date;
                    $day = $cd_date_array[1];
                    $month = $cd_date_array[0];
                    $year = $cd_date_array[2];
                    
                    if(!checkdate($month,$day,$year)) {
                        $creditCardDateErr2 = "Your date must be in mm/dd/yyyy format. Please try again.";
                    }
                    else {
                        $today = date("m/d/Y");
                        $strToday = strtotime($today);
                        $enteredDate = strtotime($creditcarddate);
                        if($enteredDate < $strToday) {
                            $creditCardDateErr3 = "Date supplied is before present day. Please adjust.";
                        }
                        else if($enteredDate > ($strToday)) {
                            $creditCardDateErr4 = "Payment Date cannot be in the future. Please enter today's date.";
                        }
                    }
                }
                
                // verifying credit card payment amount
                if(empty($_POST['creditcardamount'])) {
                    $creditCardAmountErr = "Please enter your payment amount.";
                }
                else {
                    $creditcardamount = test_input($_POST['creditcardamount']);
                    $creditcardamount_pattern = '/^[0-9]+.[0-9][0-9]*$/';
                    preg_match($creditcardamount_pattern,$creditcardamount,$creditcardamount_match);
                    if(!$creditcardamount_match[0]) {
                        $creditCardAmountErr2 = "Credit card payment amount must be numeric. Please try again.";
                    } // may need to check that credit card is greater than $5.
                    else if (($creditcardamount == 0) || ($creditcardamount > 50000)) {
                        $creditCardAmountErr3 = "Credit card payment amount must be greater than 0 and less than $50K.";
                    }
                }
            } /* end of validation for credit card data */
            else if(isset($paymentmethodid) && ($paymentmethodid == "Cash")) {
                
                // verifying cash payment amount
                if(empty($_POST['cashamount'])) {
                    $cashAmountErr = "Please enter your cash payment amount.";
                }
                else {
                    $cashamount = test_input($_POST['cashamount']);
                    $cashamount_pattern = '/^[0-9]+.[0-9][0-9]*$/';
                    preg_match($cashamount_pattern,$cashamount,$cashamount_match);
                    if(!$cashamount_match[0]) {
                        $cashAmountErr2 = "The cash payment amount must be numeric. Please try again.";
                    } // do not let anyone add zero dollars as payment.
                    else if ($cashamount == 0) {
                        $cashAmountErr3 = "Your cash payment amount cannot be $0. Enter a valid value.";
                    }
                }
                
                // verify cash payment date
                if(empty($_POST['cashpaymentdate'])) {
                    $cashPaymentDateErr = "Please enter the date of your cash payment.";
                }
                else {
                    $cashpaymentdate = test_input($_POST['cashpaymentdate']);
                    $date_array = explode("/",$cashpaymentdate);
                    // break out date;
                    $day = $date_array[1];
                    $month = $date_array[0];
                    $year = $date_array[2];
                    
                    if(!checkdate($month,$day,$year)) {
                        $cashPaymentDateErr2 = "Your date must be in mm/dd/yyyy format. Please try again.";
                    }
                    else {
                        $today = date("m/d/Y");
                        $strToday = strtotime($today);
                        $enteredDate = strtotime($cashpaymentdate);
                        if($enteredDate < $strToday) {
                            $cashPaymentDateErr3 = "Date supplied is before present day. Please adjust.";
                        }
                        else if($enteredDate > ($strToday)) {
                            $cashPaymentDateErr4 = "Payment Date cannot be in the future. Please enter today's date.";
                        }
                    }
                }
                
            } /* end of data validation depending upon Payment Method */
            
            // Validation Complete if all above conditions are successfully met.  Check.
            // Generate the form submission completed successfully message
            // Note: may not need this big if statement; just use validation flag; research that.
            
            if($paymentMethodIDErr ==="" && $checkNumberErr === "" && $checkNumberErr2 === "" && $checkDateErr === "" && $checkDateErr2 === "" && $checkDateErr3 === "" && $checkAmountErr === "" && $checkAmountErr2 === "" && $checkAmountErr3 === "" && $checkAccountNumberErr === "" && $checkAccountNumberErr2 === "" && $checkRoutingNumberErr === "" && $checkRoutingNumberErr2 === "" && $creditCardTypeErr === "" && $creditCardNameErr === "" && $creditCardNameErr2 === "" && $creditCardNumberErr === "" && $creditCardNumberErr2 === "" && $creditCardExpirationErr === "" && $creditCardExpirationErr2 === "" && $creditCardExpirationErr3 === "" && $creditCardCVCErr === "" && $creditCardCVCErr2 === "" && $creditCardDateErr === "" && $creditCardDateErr2 === "" && $creditCardDateErr3 === "" && $creditCardDateErr4 === "" && $creditCardAmountErr === "" && $creditCardAmountErr2 === "" && $creditCardAmountErr3 === "" && $cashAmountErr === "" && $cashAmountErr2 === "" && $cashAmountErr3 === "" && $cashPaymentDateErr === "" && $cashPaymentDateErr2 === "" && $cashPaymentDateErr3 === "" && $cashPaymentDateErr4 === "") {
                $msg_success = nl2br("Your payment has been recorded.  Thank you!\r\nReady to record another?  Please choose your payment method.\r\r\nNOTE: You are providing payment for the same order id.\r\nIf you would like to choose another order, please go to the Orders Page and select another.");
            }
            
            
        } // end of processing isset POST submit
        
        /* beginning customization of fieldset styles based on payment method selection */
        if($paymentmethodid === "") {
            echo '<style>#creditcard-pymt, #cash-pymt, #check-pymt {display:none;}</style>';
            echo '<script type="text/javascript">#paymentform.reset();';
            clear_form();
        }
        else if($paymentmethodid === "Cash") {
            echo '<style>#creditcard-pymt, #check-pymt {display:none;} #cash-pymt {display:block;}</style>';
        }
        else if($paymentmethodid === "Check") {
            echo '<style>#creditcard-pymt, #cash-pymt {display:none;} #check-pymt {display:block;}</style>';
        }
        else if($paymentmethodid === "Credit Card") {
            echo '<style>#cash-pymt, #check-pymt {display:none;} #creditcard-pymt {display:block;}</style>';
        } /* end of customizing style based on payment method */
        
//        print_r($_POST);
        
        // end of echoing all variables within this function
        
    } // end of function validateFeedbackForm($arr)
    
?>
