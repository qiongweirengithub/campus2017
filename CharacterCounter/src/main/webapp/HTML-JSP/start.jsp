<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title></title>
    <script src="js/ionic.bundle.min.js"></script>
    <script src="js/ng-file-upload/ng-file-upload-shim.min.js"></script>
    <script src="js/ng-file-upload/ng-file-upload.min.js"></script>
    <script src="js/ng-file-upload/jquery-3.2.1.min.js"></script>

    <%--<script src="js/angular.min.js"></script>--%>
    <%--<script src="js/ionic.js"></script>--%>
    <%--<script src="js/ionic-angular.js"></script>--%>
    <link rel="stylesheet" href="css/ionic.min.css"/>
    <style>
        .fixed:after{
            display:block;
            content:"";
            clear:both;
        }

    </style>
    <style type="text/css">
        .upload {
            position: relative;
            display: inline-block;s
            height: 33px;
            line-height: 33px;
            overflow: hidden;
            vertical-align: middle;
            cursor: pointer;
        }

        .upload .upload-input-file {
            position: absolute;
            right: 0;
            top: 0;
            font-size: 100px;
            opacity: 0;
            filter: alpha(opacity=0);
            cursor: pointer;
        }

        .upload .upload-btn {
            outline: none;
            border: 0;
            padding: 7px 10px;
            color: #fff;
            background: #1c84c6;
            cursor: pointer;
            margin: 3px;
            border-radius: 3px;
        }

        .upload .upload-url {
            -moz-box-sizing: border-box;
            -webkit-box-sizing: border-box;
            box-sizing: border-box;
            border-radius: 2px;
            border: solid 1px #ddd;
            width: 200px;
            height: 30px;
            -webkit-line-height: 1;
            line-height: 30px\9;
            -ms-line-height: 30px;
            text-indent: 3px;
        }

        .upload .upload-tip {
            display: none;
            background-color: #1c84c6;
            padding: 2px 10px;
            color: #fefefe;
            font-size: 12px !important;
            border-radius: 3px;
        }
    </style>
</head>
<body ng-app="myApp" ng-controller="myCtrl">
<h2>请选择一段文字</h2>

    <input type="radio" name="type"  style="margin-left:20px;" checked/>
    <label for="">文件上传</label>
    <input type="radio" name="type" style="margin-left:100px;"/>
    <label for="">文本输入</label>
    <br/>
    <div id="file1" class="change fixed" >
        <form name="Form2" action="/CharacterCounter/springUploadFile" method="post"  enctype="multipart/form-data">
            <span class="upload" style ="float:left">
            <input type="button" class="button button-small button-calm " style="float:left;height:30px;margin:15px 0 20px 20px ;padding:0 15px;float:left;" value="upload" />
             <input type="text"  class="upload-url" style="float:left;margin:15px" />
             <input type="file" class="upload-input-file" id="upload-input-file" name="file" />
         <input class="button button-small button-calm " style="float:left;height:30px;margin:15px 0 20px 20px ;padding:0 15px;float:left;" type="submit"  name="file" value="统计">

            </span>

            <!--<input class="button button-small button-calm " style="height:30px;margin:15px 0 20px 20px ;padding:0 15px;float:left;" type="file" name="file" value="上传文件"> -->

        </form>
    </div>

    <div id="file2" class="change fixed" style="width:400px;display:none;">
        <textarea name="text" id="text" ng-model="saveText.text" cols="30" rows="4" style="border:1px solid grey;overflow-y: scroll;float:left;margin-left:20px;resize:none;" placeholder="请再此输入文本内容"></textarea>
        <div class="button button-small button-calm " style="height:30px;margin:0 0 0 20px ;padding:0 30px;float:left;" ng-click="count()">统计</div>
        <div class="button  button-small " style="height:30px;margin:8px 0 0  20px ;padding:0 17.6px;float:left;background: orange;"  ng-click="clear()"><b>清空内容</b></div>
    </div>
    <br/>

    <p style="margin-left:20px;">各统计内容的个数如下</p>
    <table width="300" border="2" cellpadding="10" cellspacing="10" style="margin-left:20px;">
        <tbody>
        <tr>
            <th style="border:1px solid #000;text-align: center;width:150px;padding:6px;" ><b>统计项</b></th>
            <th style="border:1px solid #000;text-align: center;" ><b>个&nbsp;&nbsp;数</b></th>
        </tr>
        <tr>
            <td style="border:1px solid #000;text-align: center; padding:6px;" >英文字母</td>
            <td style="border:1px solid #000;text-align: center;" >{{tongji.english}}</td>
        </tr>
        <tr>
            <td style="border:1px solid #000;text-align: center;padding:6px; " >数字</td>
            <td style="border:1px solid #000;text-align: center;" >{{tongji.number}}</td>
        </tr>
        <tr>
            <td style="border:1px solid #000;text-align: center; padding:6px;" >中文汉字</td>
            <td style="border:1px solid #000;text-align: center;" >{{tongji.chinese}}</td>
        </tr>
        <tr>
            <td style="border:1px solid #000;text-align: center;padding:6px; " >中英文标点符号</td>
            <td style="border:1px solid #000;text-align: center;padding:6px;" >{{tongji.biaodian}}</td>
        </tr>
        </tbody>
    </table>
    <br/>

    <p style="margin-left:20px;">文字中出现频率最高的三个字是</p>
    <table width="300" border="2" cellpadding="10" cellspacing="10" style="margin-left:20px;">
        <tr>
            <th style="border:1px solid #000;text-align: center;width:150px;padding:6px;" ><b>统计项</b></th>
            <th style="border:1px solid #000;text-align: center;" ><b>个&nbsp;&nbsp;数</b></th>
        </tr>
        <tr>
            <td style="border:1px solid #000;text-align: center; height:21px;padding:0 6px;" >{{lisMostNum[0]['name']}}</td>
            <td style="border:1px solid #000;text-align: center;" >{{lisMostNum[0]['num']}}</td>
        </tr>
        <tr>
            <td style="border:1px solid #000;text-align: center; height:21px;padding:0 6px;" >{{lisMostNum[1]['name']}}</td>
            <td style="border:1px solid #000;text-align: center;" >{{lisMostNum[1]['num']}}</td>
        </tr>
        <tr>
            <td style="border:1px solid #000;text-align: center; height:21px;padding:0 6px;" >{{lisMostNum[2]['name']}}</td>
            <td style="border:1px solid #000;text-align: center;" >{{lisMostNum[2]['num']}}</td>
        </tr>
    </table>

</body>
<script type="text/javascript">



    var radio = document.getElementsByName("type");
    radio[0].onclick =function(){
        document.getElementsByTagName("h2")[0].innerText = "请选择一段文字";

        document.getElementById("file1").style.display="block";
        document.getElementById("file2").style.display="none";

    };
    radio[1].onclick =function(){

        document.getElementsByTagName("h2")[0].innerText = "请输入一段文字";
        document.getElementById("file2").style.display="block";
        document.getElementById("file1").style.display="none";
    };

    angular.module("myApp",["ionic"]).controller("myCtrl",function($scope,$http,$location,$window){

        $scope.absUrl = $location.absUrl();
        $scope.protocol = $location.protocol();
        $scope.host = $location.host();
        $scope.port = $location.port();

        $scope.jumpToUrl = function(path){
            //alert($window.location.href);
            var loc = "http://localhost:8080/CharacterCounter/";
            loc = loc + path;
            //alert(loc)
            $window.location.href = loc;
        }

        $scope.saveText = {
            text:null
        }

        $scope.count = function() {
           // alert($scope.saveText);
          // alert("sfgsdgdf");
            if($scope.saveText==null){
                //alert("ok");
                $scope.tongji = null;
                $scope.lisMostNum = null;
            }else {
                $http({
                    method: "POST",
                    url: "http://localhost:8080/CharacterCounter/TestAjax",
                    data: $scope.saveText
                }).success(function (data, status) {
                    $scope.tongji = data[0].statics;
                    $scope.lisMostNum = data[0].lisMostNum;
                })
            }
        }

        $scope.clear = function(){
            var text1 = document.getElementById("text");
            text1.value="";
            $scope.tongji = null;
            $scope.lisMostNum = null;
            $scope.saveText = null;
        }

        $scope.UpCompute = function(){
            $http({
                method: "POST",
                url: "http://localhost:8080/CharacterCounter/TongJi"
            }).success(function(data,status){
                if(data[0] == null){
                    alert("并未上传文件！");
                    $scope.tongji = null;
                    $scope.lisMostNum = null;
                }else {
                    $scope.tongji = data[0].statics;
                    $scope.lisMostNum = data[0].lisMostNum;
                }
            })

        }
    })

    $("#upload-input-file").change(function () {

        if ($(this).parent().html().indexOf("class=\"upload-url\"") != -1) {
            var fileUrl = $(this).val();
           // alert(fileUrl);
            $(this).parent().children(".upload-url").val(fileUrl);
        }
        else {
            var fileUrl = $(this).val();
            var urlArr = fileUrl.split("\\");
            var getName = urlArr[urlArr.length - 1];
            $(this).parent().children(".upload-tip").text(getName).fadeIn("slow");
            //$(this).parent().children(".upload-btn").val(getName);
            timeout = setTimeout(function () {
                $(".upload-tip").fadeOut("slow");
            }, 5000);
        }
    });


</script>
</html>
