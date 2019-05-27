<template>
    <div class="reportDetail">
        <div class="centerContent">
            <list-header :headerList="headerList" v-if="headerList.length>0" ref="listHead"></list-header>
            <!--加载框-->
            <fixed-loading v-if="loading"></fixed-loading>
            <!--附件信息-->
            <attachment-group :imgList="imgList" :imageTemArr="imageTemArr" :fileList="fileList" :imgParams="imgParams"
                              ref="imageGroup" :readOnly="readOnly"></attachment-group>

            <list-line :readOnly="readOnly" :dataList="lineList" title="单据行信息" @add="addLine(createType)"
                       @toDetail="toLine" @deleteLine="deleteDetail"></list-line>
            <list-line :readOnly="readOnly" :dataList="schedList" title="收款方信息" @add="goVerf('-1')" @toDetail="goVerf"
                       @deleteLine="deleteSchd"></list-line>
        </div>
        <div class="buttons">
            <button class="uploadBtn" v-on:click="uploadImage('save')" v-if="!readOnly">保存并上传附件</button>
            <button class="submitBtn" v-on:click="checkInvoice" v-if="!readOnly">提交</button>
            <button class="backBtn" v-on:click="onClickBack" v-if="readOnly">返回</button>
        </div>
    </div>
</template>

<script type="text/ecmascript-6">
    import Axios from "../../service/AxiosPlugin";
    import Drag from '../../service/drag.js';
    import imageService from "../../service/imageService";
    import ListLine from "../../components/hec/list-line";
    import ListHeader from "../../components/hec/list-header";
    import attachmentGroup from '../../components/attachment-group.vue';
    import FixedLoading from '../../components/base-ui/fixed-loading.vue';
    import Utils from "../../utils/utils";
    import ComboxService from '../../service/comboxService';

    export default {
        name: 'report-detail',
        components: {
            FixedLoading,
            attachmentGroup,
            ListHeader,
            ListLine
        },
        data() {
            return {
                userId:"",
                headerId:"",
                header:{},
                lines:[],
                headerList:[],
                lineList:[],
                schedList:[],
                schedulesList:[],
                apply_condition:"",
                loading: false,
                readOnly:false,
                createType:"",
                userName:"",
                imgList:[],
                fileList:[],
                imageTemArr:[],
                imgParams:{},

                successFlag:false,
                due_amount:0,
            }
        },
        deactivated(){
            this.headerId = "";
            this.clearData();
        },
        activated(){
            let routerParams = this.$route.params;
            this.headerId = routerParams.headerId;
            let user = this.getLocalValue("hecUserDefault");
            this.userId = user.user_id;
            this.userName = user.user_name;
            this.showHiddenContent = false;
            this.header ={};
            this.initPage();
        },
        methods: {
            clearData(){
                this.headerList = [];
                this.header ={};
                this.lines=[];
                this.lineList = [];
                this.schedList = [];
                this.schedulesList = [];
                this.imgParams = {};
                this.fileList = [];
                this.imgList = [];
                this.imageTemArr =[];
            },
            setHeader(){
                this.headerList = [];
                if(this.header.reject_reason){
                    this.headerList.push({
                        title:"拒绝原因",
                        value:this.header.reject_reason,
                        alwaysShow:'Y'
                    });
                }
                this.headerList.push({
                    title:"单据编号",
                    value:this.header.exp_report_number,
                    alwaysShow:'N'
                });
                this.headerList.push({
                    title:"报销日期",
                    value:this.header.exp_report_data,
                    alwaysShow:'N'
                });
                this.headerList.push({
                    title:"报销公司",
                    value:this.header.company_name,
                    alwaysShow:'Y'
                });
                this.headerList.push({
                    title:"报销人",
                    value:this.header.employee_name,
                    alwaysShow:'N'
                });
                this.headerList.push({
                    title:"报销金额",
                    value:this.header.sum_amount,
                    alwaysShow:'Y',
                    amountFlag:"Y"
                });
                // this.headerList.push({
                //     title:"关联交易",
                //     value:this.header.related_transactions_name,
                //     alwaysShow:'N'
                // });
                // this.headerList.push({
                //     title:"支付公司",
                //     value:this.header.pay_company_full_name,
                //     alwaysShow:'N'
                // });
                this.headerList.push({
                    title:"事由",
                    value:this.header.exp_report_description,
                    alwaysShow:'N'
                });
            },
            setLines(){
                this.lineList=[];
                for(let i=0;i<this.lines.length;i++){
                    let list=[{
                        title:"行号",
                        value:this.lines[i].line_number
                    },{
                        title:"部门",
                        value:this.lines[i].unit_name
                    },{
                        title:"费用项目",
                        value:this.lines[i].exp_req_item
                    },{
                        title:"报销金额",
                        value:this.lines[i].report_amount,
                        amountFlag:'Y'
                    },{
                        title:"事由",
                        value:this.lines[i].description
                    }];
                    let line = {
                        line:this.lines[i],
                        list:list
                    };
                    this.lineList.push(line);
                }
            },
            setSchedulesList(){
                this.schedList = [];
                for(let i=0;i<this.schedulesList.length;i++){
                    let list=[{
                        title:"收款方",
                        value:this.schedulesList[i].payee_partner_name
                    },{
                        title:"银行账号",
                        value:formatBankNumber(this.schedulesList[i].account_number)
                    },{
                        title:"付款金额",
                        value:this.schedulesList[i].due_amount,
                        amountFlag:'Y'
                    },{
                        title:"已核销金额",
                        value:this.schedulesList[i].write_off_amount,
                        amountFlag:'Y'
                    }];
                    let sched = {
                        line:this.schedulesList[i],
                        list:list
                    };
                    this.schedList.push(sched);
                }
            },
            initPage(){
                this.loading = true;
                this.successFlag = false;
                let params = {
                    "data_type": "exp_requisition_head_line",
                    "action": "query",
                    "order_type_code": "EXP_REPORT",
                    "exp_report_header_id": this.headerId,
                    "pagenum": 1,
                    "pagesize": "1000",
                    "fetchall": "false"
                };
                Axios.post(params).then(data => {
                    if (data.success) {
                        this.loading = false;
                        this.header = data.result.report_head;
                        this.setHeader();

                        this.lines = this.jsonArray(data.result.report_line);
                        this.setLines();
                        this.schedulesList=this.jsonArray(data.result.report_pmt_schedules);
                        this.setSchedulesList();
                        this.createType=this.header.create_type;
                        this.setReadOnly();
                        this.getTypeList();
                        let vm = this;
                        vm.imgParams = {
                            document_number:vm.header.exp_report_number,
                            userId:vm.userId
                        };
                        imageService.getSeqid(vm.userId,vm.header.exp_report_number,"4").then(res=>{
                           let seqid=res.result.seqid;
                           Utils.setLocalValue("seqid", res.result.seqid);
                           imageService.downloadImage(vm.header.exp_report_number,seqid).then(data=>{
                                this.imgList.length=0;
                                let files=data.returnData;
                                if(!this.isNullData(files)){
                                    for (let i = 0; i < files.length; i++) {
                                        if(files[i].Imagetype=='0'){
                                            this.imgList.push(files[i]);
                                        }
                                    }
                                }
                            }).catch(error => {
                                console.log("获取图片失败===" + error);
                                this.$handPlugin.toast.show('图片信息查询失败!');
                                this.loading = false;
                            })
                        }).catch(error => {
                            console.log("获取图片失败===" + error);
                            this.$handPlugin.toast.show('图片信息查询失败!');
                            this.loading = false;
                        })

                    } else {
                        this.loading = false;
                        console.log("费用报销单信息查询失败：" + JSON.stringify(data));
                        this.$handPlugin.toast.show('费用报销单信息查询失败!');
                    }
                }).catch(error => {
                    this.loading = false;
                });
            },
            setReadOnly(){
                if(this.header.exp_report_status ==="新建" || this.header.exp_report_status ==="拒绝"|| this.header.exp_report_status ==="收回"){
                    this.readOnly = false;
                }else{
                    this.readOnly = true;
                }
            },
            /*显示报销单头部*/
            showHeader(){
                this.showHiddenContent=!this.showHiddenContent;
            },
            //删除收款方信息
            deleteSchd(item,index){
                let params={
                    "data_type":"exp_report_delete_pmt_schd",
                    "action":"submit",
                    "parameter":{
                        "exp_report_header_id":item.exp_report_header_id,
                        "payment_schedule_line_id":item.payment_schedule_line_id,
                        "user_id":this.userId,
                        "_status":"delete"
                    }
                };
                Axios.post(params).then(data => {
                    if (data.success) {
                        this.schedulesList.splice(index,1);
                        this.schedList.splice(index,1);
                        this.$handPlugin.toast.show('收款方删除成功!');
                    } else {
                        console.log("收款方删除失败：" + JSON.stringify(data));
                        this.showPrompt("错误信息",JSON.stringify(data.error.message))
                    }
                });
            },
            //获取报销单据类型
            getTypeList(){
                this.docTypeList = [];
                let params = {
                    "data_type":"exp_report_type_list",
                    "action":"query",
                    "company_id":this.header.company_id,
                    "employee_id":this.header.employee_id,
                    "user_id":this.userId,
                    "pagenum":1,
                    "pagesize":"1000",
                    "fetchall":"false"
                };
                Axios.post(params).then(data => {
                    let list = data.result.record;
                    this.loading = false;
                    if(!this.isNullData(list)){
                        for (let i = 0; i < list.length; i++) {
                            let type = {
                                "key": list[i].expense_report_type_id,
                                "imgSrc": list[i].app_documents_icon,
                                "value": list[i].description,
                                "typeCode":list[i].expense_report_type_code,
                                "payment_method_id":list[i].payment_method,
                                "req_required_flag":list[i].req_required_flag,
                                "apply_condition":list[i].apply_condition,
                            };
                            this.docTypeList.push(type);
                            this.apply_condition = type.apply_condition;
                        }
                    }
                });
            },
            //新建费用行
            addLine(type){
                //根据创建类型，跳转不同界面
                let vm = this;
                vm.uploadImage('').then(function (data) {
                    vm.loading = false;
                    vm.successFlag = true;
                    if (type == 'TRAN') {
                        vm.$router.push({ name: 'relate-account', params: {headerId: vm.headerId, readOnly: false,create_type :vm.header.create_type,document_page_type:vm.header.document_page_type} });
                    } else if (type == 'REQEST'){
                        vm.$router.push({ name: 'relate-apply',
                            params: {headerId: vm.headerId, readOnly: false,companyId:vm.header.company_id,expRepTypeId:vm.header.exp_report_type_id,create_type :vm.header.create_type,document_page_type:vm.header.document_page_type}
                        });
                    }else if(type == 'MANUAL'){
                        vm.$router.push({ name: 'report-line',
                        params: {
                            headerId: vm.headerId,
                            readOnly: false,
                            sum_amount:vm.header.sum_amount,
                            apply_condition:vm.header.apply_condition,
                            create_type :vm.header.create_type,
                            document_page_type:vm.header.document_page_type,
                            exp_report_data:vm.header.exp_report_data} });//报销日期
                    }
                }).catch(error => {
                    vm.loading = false;
                });
            },
            //判断是否有新增图片需要上传
            isChanged(){
                if(this.imageTemArr.length > 0){
                    return true;
                }else{
                    return false;
                }
            },
            onClickBack(){
                let _this = this;
                if(_this.isChanged()){
                    _this.$handPlugin.confirm.show({
                        content:"是否上传刚新增的图片?",
                        leftButtonText: "取消",
                        rightButtonText: "确认上传",
                        leftClick(){
                            _this.successFlag = true;
                            _this.$router.push({name: 'report-list'});
                        },
                        rightClick(){
                            _this.uploadImage('saveAndBack');
                        },
                    });
                }else{
                    _this.successFlag = true;
                    _this.$router.push({name: 'report-list'});
                }
            },
            //删除报销单行
            deleteDetail(item,index){
                let params={
                    "data_type":"exp_report_line_delete",
                    "action":"submit",
                    "parameter":{
                        "exp_report_line_id":item.exp_report_line_id,
                        "user_id":this.userId,
                        "exp_report_header_id":item.exp_report_header_id,
                        "_status":"execute"
                    }
                };
                Axios.post(params).then(data => {
                    if (data.success) {
                        this.clearData();
                        this.initPage();
                        this.$handPlugin.toast.show('报销单行删除成功!');
                    } else {
                        console.log("报销单行删除失败：" + JSON.stringify(data));
                        this.showPrompt("错误信息",JSON.stringify(data.error.message))
                    }
                });
            },
            //跳转核销界面
            goVerf(index){
                let item;
                let status="new";
                if(index>=0){
                    item = this.schedulesList[index];
                    status="old";
                }
                let vm = this;
                vm.uploadImage('').then(function (data) {
                    vm.loading = false;
                    vm.successFlag = true;
                    vm.$router.push({
                        name:'verf-edit',
                        params:{
                            schedules:item,
                            //schedulesList:vm.schedulesList,
                            headerId:vm.headerId,
                            sumAmount:vm.header.sum_amount,
                            status:status,
                            description:vm.header.exp_report_description,
                            readOnlyFlag:vm.readOnly}
                    });
                }).catch(error => {
                    vm.loading = false;
                });
            },
            //跳转详细费用行
            toLine(index){
                let item = this.lines[index];
                let vm = this;
                item.exp_report_type_id =  vm.header.exp_report_type_id;
                vm.uploadImage('').then(function (data) {
                    vm.loading = false;
                    vm.successFlag = true;
                    vm.$router.push({
                        name: 'report-line',
                        params: {
                            headerId: vm.headerId,
                            readOnly: vm.readOnly,
                            line: item,
                            companyId: vm.header.company_id,
                            docTypeId: vm.header.exp_report_type_id,
                            sum_amount:vm.header.sum_amount,
                            apply_condition:vm.header.apply_condition,
                            create_type :vm.header.create_type,
                            document_page_type:vm.header.document_page_type,
                            exp_report_data:vm.header.exp_report_data
                        }
                    });
                }).catch(error => {
                    vm.loading = false;
                });
            },
            //报销的提交前检验数据是否完整
            presubmitHeader(){
                this.due_amount=0;
                for(let i=0;i<this.schedulesList.length;i++){
                    this.due_amount+=this.schedulesList[i].due_amount;
                }
                if(this.header.sum_amount!=this.due_amount){
                    this.$handPlugin.toast.show('报销单行数据总金额与计划付款行总金额必须相同');
                    return false;
                }
                //console.log(this.lines.length);
                for(var i=0;i<this.lines.length;i++){
                    if (this.isNullData(this.lines[i].exp_req_item_name)) {
                        this.$handPlugin.toast.show('单据行上必输字段不能为空');
                        return false;
                    }
                    if(this.isNullData(this.lines[i].expense_type_id)){
                        this.$handPlugin.toast.show('单据行上必输字段不能为空');
                        return false;
                    }
                    // if(this.isNullData(this.lines[i].invoice_status_desc)){
                    //     this.$handPlugin.toast.show('单据行上必输字段不能为空');
                    //     return false;
                    // }
                }

                return true;
            },

            //提交前验真校验
            checkInvoice(){
                let _this=this;
                let flag=1;
                ComboxService.checkReportDoc(_this.headerId).then(data=>{
                    if(data.success){
                        let invoic=data.result.record;
                        if(_this.isNullData(invoic)){
                            flag=1;
                        }else{
                            for(let i=0;i<invoic.length;i++){
                              let item = invoic[i];
                                if(item.return_msg!='C_INTERFACE'&&item.return_msg!='SUCCESS'){
                                    ComboxService.checkInvoice(item.checkcode,item.invoicecode,item.invoicenumber,item.billingdate,item.totalamount,item.reportdistsid,_this.userId).then(data=>{
                                        if(data.result.returnMsg!='success'){
                                            flag=0;
                                            return;
                                        }
                                    })
                                }else{
                                    flag=1;
                                }
                            }
                        }
                    }else{
                        flag=0;
                        _this.showPrompt("错误信息",JSON.stringify(data.error.message));
                    }
                }).then(()=>{
                    setTimeout(function(){
                        // alert(flag);
                        if(flag===1){
                            _this.submitHeader();
                        }else if(flag===0){
                            _this.$handPlugin.toast.show('发票验真失败!');
                        }
                    },200);
                })
            },
            //报销单提交
            submitHeader(){
                console.log(this.lines);
                if(this.presubmitHeader()){
                     let _this = this;
                    _this.loading = true;
                    _this.uploadImage('').then(function(data){
                        return _this.validateHeader("N");
                    },function(err){
                        _this.loading = false;
                    }).then(function(data){
                        if(data=="S"){
                            _this.submitData();
                        }
                    },function(err){
                        _this.loading = false;
                        console.log("validateHeader failed ==="+err);
                    })
                }
            },
            uploadImage(type){
                return new Promise((resolve, reject) => {
                    let vm = this;
                    vm.loading = true;
                    if (vm.imageTemArr.length > 0) {
                        vm.$refs.imageGroup.uploadImages().then(res => {
                            vm.imageTemArr = [];
                            if(type ==="save"){
                                vm.loading = false;
                                vm.$handPlugin.toast.show('图片上传成功!');
                            }else if (type === "saveAndBack") {
                                vm.successFlag = true;
                                vm.loading = false;
                                vm.$router.push({name: 'report-list'});
                            }
                            resolve("S");
                        }).catch(error => {
                            vm.imageTemArr = [];
                            vm.loading = false;
                            reject("E");
                        });
                    } else {
                        resolve("S");
                        if(type ==="save"){
                            vm.loading = false;
                            vm.$handPlugin.toast.show('没有添加新图片，无需上传!');
                        }
                    }
                });
            },
            //头部校验
            validateHeader(flag){
                return new Promise((resolve, reject) => {
                    let _this = this;
                    let params = {
                        "data_type": "exp_report_bgt_control",
                        "action": "submit",
                        "parameter":{
                            "exp_report_header_id": this.headerId,
                            "user_id":this.userId,
                            "flag":flag,
                            "error_level_code":"",
                            "message_code":"",
                            "_status":"execute"
                        }
                    };
                    Axios.post(params).then(data => {
                        if (data.success) {
                            if(flag == "N"){
                                if(data.result.error_level_code =="ALLOWED") {
                                    _this.loading = false;
                                    _this.$handPlugin.confirm.show({
                                        content:data.result.message_code,
                                        leftButtonText: "取消",
                                        rightButtonText: "确认",
                                        leftClick(){
                                            reject("E");
                                        },
                                        rightClick(){
                                            resolve("S");
                                        },
                                    });
                                }else if(data.result.error_level_code =="BLOCK"){
                                    _this.loading = false;
                                    this.showPrompt("错误信息",JSON.stringify(data.result.message_code))
                                    reject("E");
                                }else{
                                    resolve("S");
                                }
                            }else{
                                resolve("S");
                            }
                        } else {
                            console.log("报销单信息验证失败，错误信息：" + JSON.stringify(data));
                            this.showPrompt("错误信息",JSON.stringify(data.error.message))
                            reject("E");
                        }
                    }).catch(() => {
                        _this.$handPlugin.toast.show('报销单信息验证失败!');
                        reject("E");
                    });
                });
            },
            //头部提交
            submitData(){
                let _this = this;
                if(!_this.loading){
                    _this.loading = true;
                }
                _this.validateHeader("Y").then(data=>{
                    let params = {
                        "data_type":"exp_report_submit",
                        "action":"submit",
                        "parameter":{
                            "exp_report_header_id": _this.headerId,
                            "user_id":_this.userId,
                            "_status":"execute"
                        }
                    };
                    Axios.post(params).then(data => {
                        if (data.success) {
                            _this.successFlag = true;
                            _this.$router.push({name: 'report-list'});
                        } else {
                            console.log("报销单信息提交失败，错误信息：" + JSON.stringify(data));
                            this.showPrompt("错误信息",JSON.stringify(data.error.message))
                        }
                        _this.loading = false;
                    }).catch(() => {
                        _this.loading = false;
                        _this.$handPlugin.toast.show('报销单信息提交错误!');
                    });
                });
            }
        },
        beforeRouteLeave: function(to, from, next) {
            if(this.successFlag || to.name == "report-list"){
                this.successFlag = false;
                next();
                return;
            }
            next(false);
            this.onClickBack();
        }
    }


     /**
        Author:Yuan.Gao
        Date:2018-07-11
        Change:用于银行账户*号显示
    */
    function formatBankNumber(bankNumber){
        return bankNumber.substr(0,4)+"***"+bankNumber.substr(-4);
    }

</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style lang="scss">
    @import "../../assets/scss/_variables.scss";

    .reportDetail {
        .centerContent {
            padding-bottom: 90px;
        }
        .buttons {
            position: absolute;
            bottom: 0;
            width: 100%;
            z-index: 100;
            .uploadBtn {
                background-color: white;
                color: black;
                float: left;
                width: 50%;
                height: 45px;
                border-width: 0;
                font-size: 16px;
            }
            .submitBtn {
                background-color: rgb(210, 24, 16);
                color: white;
                float: right;
                width: 50%;
                height: 45px;
                border-width: 0;
                font-size: 16px;
            }
            .backBtn {
                background-color: white;
                color: black;
                width: 100%;
                height: 45px;
                border-width: 0;
                font-size: 16px;
            }
        }
    }

</style>
