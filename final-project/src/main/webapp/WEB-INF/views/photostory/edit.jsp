<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<script>
	var sel_files = [];
	var delete_no =[];
	$(function(){

		$(".story-photo").height($('.upload_img').width()+'px')
		$(".input_img").on("change",handleImgFileSelect)
		$( window ).resize(function() {
			$(".story-photo").height($('.upload_img').width()+'px')
		});
		
		$(".submit_btn").click(function(e){
			for(let i=0;i<sel_files.length;i++){
				var $input = $('<input type="hidden" name="index" value="'+sel_files[i]+'">');
				$(".photostory_form").append($input)
			}
			for(let i=0;i<delete_no.length;i++){
				var $input = $('<input type="hidden" name="deleteNo" value="'+delete_no[i]+'">');
				$(".photostory_form").append($input)
			}
			
			$("#photostoryContent").val(document.querySelector("mini-editor")._children.outp.innerHTML)
			let tag = document.querySelector("mini-editor")._children.outp.querySelectorAll(".hashtag")
			for(let i=0;i<tag.length;i++){
				$(".photostory_form").append($('<input/>', {type: 'hidden', name: 'hashtag', value:tag[i].textContent}));
			}
		})
	})
	
	
	function handleImgFileSelect(e){
		sel_files=[];
		
		var files = e.target.files;
		var filesArr = Array.prototype.slice.call(files);
		
		var index = 0;
		
		filesArr.forEach(function(f){
			
			$(".prev_img").remove();
			var reader = new FileReader();
			reader.onload = function(e){
				var html = '<div class="d-inline-block position-relative story-photo prev_img" id="img_id_'+index+'" style="width: 24%;height:'+$('.upload_img').width()+'px"> <img class="upload_img story-photo h-100 add_img" src="'+e.target.result+'"> <i class="fas fa-times text-danger position-absolute" onclick="deleteImageAction('+index+')" style="right:4%; top:4%; font-size: 1rem"></i> </div>';
				$(".imgs_wrap").append(html);
				sel_files.push(index);
				index++
			}
			reader.readAsDataURL(f);
		})
	}
	function deleteExistenceImage(no){
		delete_no.push(no)
		
		let img_id = "#del_id_"+no
		$(img_id).remove();
	}
	function deleteImageAction(index){
		console.log('index =' + index)
		sel_files.splice(sel_files.indexOf(index),1);
		
		let img_id = "#img_id_"+index
		$(img_id).remove();
		console.log(sel_files);
	}
</script>
<style>
	div.editable {
    width: 300px;
    height: 200px;
    padding:1rem;
    border: 1px solid #dcdcdc;
    overflow-y: auto;
	}
	mini-editor {
	height:200px;
	width:100%;
  	font-family:sans-serif;
    border: 1px solid #dcdcdc;
   	overflow-y: auto;
	}
</style>
<main>
	<div class="container-lg">
		<div class="row">
			<div class="jumbotron col-lg-6 offset-lg-3">
				<h3 class="display-5">스토리 수정</h3>
			</div>
			<div class="col-lg-6 offset-lg-3 text-center">
				<form action="edit" method="post" class="photostory_form encrypt-form"
					enctype="multipart/form-data">
					<!-- 	프로필 사진 업로드 -->
					<div class="form-row mb-3">
						<label for='photostoryPhoto'>스토리 사진</label>
					</div>
					<div class="form-row mb-3 row ">
						<div class="col text-left imgs_wrap">
						<label for="photostoryPhoto" style="width: 24%"> <img
							class='upload_img story-photo'
							src="${pageContext.request.contextPath}/image/photo_story_default.png"
							>
							 <input
							class="input_img" type="file" accept=".png, .jpg, .gif"
							id="photostoryPhoto" name="photostoryPhoto" style="display: none" multiple/>
						</label>
						<c:forEach var="photostoryPhotoDto" items="${photostoryPhotoList}">
							<div class="d-inline-block position-relative story-photo" id="del_id_${photostoryPhotoDto.photostoryPhotoNo}" style="width: 24%;height:'+$('.upload_img').width()+'px">
								<img class="upload_img story-photo h-100 add_img" src="${pageContext.request.contextPath}/photostory/photo/${photostoryPhotoDto.photostoryPhotoNo}">
								<i class="fas fa-times text-danger position-absolute" onclick="deleteExistenceImage(${photostoryPhotoDto.photostoryPhotoNo})" style="right:4%; top:4%; font-size: 1rem"></i> 
							</div>
						</c:forEach>
						</div>
					</div>
					
					<div class="form-row mb-3">
						<input type="hidden" name="photostoryNo" value="${photostoryListDto.photostoryNo}">
						<label for="photostoryContent">스토리 내용</label> 
						<mini-editor placeholder="내용을 입력하세요 (#해시태그)"  ></mini-editor>
						<small id="emailHelp" class="form-text text-muted"></small>
						<input type="hidden" name="photostoryContent" id="photostoryContent">
					</div>
					
					<div class="form-row mb-5 justify-content-around">
						<button class="btn btn-primary submit_btn btn-block" type="submit">수정</button>
						<button class="btn btn-secondary cancel-btn btn-block"
							type="button">취소</button>
					</div>
				</form>
			</div>
		</div>
	</div>
</main>



<script>

class MiniEditor extends HTMLElement {
	  constructor(){
	    super();
	    this._value = '';
	  }

	  connectedCallback(){
	    var shadow = this.attachShadow({ mode:'open'});
	    var wrapper = document.createElement('div');
	    var placeholder = document.createElement('div');
	    var outp = document.createElement('div');
	    var inp = document.createElement('div');

	    wrapper.setAttribute('class', 'editor-body');

	    var style = document.createElement('style');
	    style.textContent = `
	    div.editor-body {
	      width:100%;
	      height:100%;
	      overflow-y:auto;
	      overflow-x:none;
	      min-height:5em;
	      border-top:solid 1px #eee;
	      border-bottom:solid 1px #eee;
	      position:relative;
	      box-sizing:border-box;
	    }

	    div.editor-body>div {
	      box-sizing:border-box;
	      padding:1rem;
	    }

	    div.outp, div.placeholder{
	      pointer-events:none;
	    }

	    div.outp>span.hashtag{
	      color:#007bff;
	    }
	    div.outp>span.mention{
	      background:#69c;
	      color:white;
	      border-radius:.5em;
	      padding:0 .2em;
	      margin:0 -.2em;
	    }

	    div.placeholder {
	      color:#999;
	    }

	    .inp {
	      z-index:1;
	    }
	    div.outp {
	      z-index:2;
	    }

	    div.outp, .inp, div.placeholder {
	      text-align:left;
	      width:100%;
	      height:auto;
	      min-height:100%;
	      position:absolute;
	      top:0;
	      left:0;
	      overflow-y:visible;
	    }
	    div.outp:focus, .inp:focus, div.placeholder:focus {
	      outline:none;
	    }
	    `;

	    placeholder.setAttribute('class', 'placeholder');
	    if( this.hasAttribute('placeholder') ){
	      placeholder.innerHTML;
	    }else{
	      console.log(this.hasAttribute('placeholder'));
	      placeholder.innerHTML = '';
	    }


	    outp.setAttribute('class', 'outp');
	    inp.setAttribute('class', 'inp');
	    inp.setAttribute('contenteditable', true);

	    inp.addEventListener('input', this.update.bind(this), false);
	    inp.addEventListener('keydown', this.keydown.bind(this), false);
	    inp.addEventListener('paste', this.paste.bind(this), false);
	   
	    inp.innerHTML = `${photostoryListDto.photostoryContent}`;
	    outp.innerHTML = `${photostoryListDto.photostoryContent}`;
	    
	    shadow.appendChild(wrapper);
	    shadow.appendChild(style);

	    wrapper.appendChild(placeholder);
	    wrapper.appendChild(inp);
	    wrapper.appendChild(outp);

	    this._children = {
	      placeholder, inp, outp
	    };
	    if(this.hasAttribute('value')){
	      this._value = this.getAttribute('value');
	      this.checkvalue();
	    }
	    this.shadow = shadow;
	  }

	  checkvalue(){
	    if( this._value.length > 0 ){
	      this._children.placeholder.style.display = 'none';
	    }else{
	      this._children.placeholder.style.display = 'block';
	    } 
	    this._children.outp.innerHTML = this._value;
	  }

	  set value(v){
	    this._value = v;
	    this.checkvalue();
	  }

	  get value(){
	    return this._value;
	  }

	  update(e){
	    var str = e.target.innerText;
	    str = str
	      .replace(/[<>\&]/gim, (i)=>'&#' + i.charCodeAt(0) + ';')
	      .replace(/\n/g, "&nbsp;\n<br />")
	      .replace(/^(#\S+)/g, "<span class='hashtag'>$1</span>")
	      .replace(/([^\&])(#\S+)/g, "$1<span class='hashtag'>$2</span>")
	      .replace(/^(@\S+)/g, "<span class='mention'>$1</span>")
	      .replace(/([^\&])(@\S+)/g, "$1<span class='mention'>$2</span>");
	    this.value = str;
	  }

	  putAtCaret(content){
	    let sel, range;
	    if( this.shadow.getSelection ){
	      sel = this.shadow.getSelection();
	      if( sel.getRangeAt && sel.rangeCount ){
	        range = sel.getRangeAt(0);
	        range.deleteContents();
	        var el = document.createElement('div');
	        el.innerHTML = content;
	        var frag = document.createDocumentFragment(), node, lastNode;
	        while( (node=el.firstChild) ){
	          lastNode = frag.appendChild(node);
	        }
	        range.insertNode(frag);
	        if( lastNode ){
	          range = range.cloneRange();
	          range.setStartAfter(lastNode);
	          range.setEndAfter(lastNode);
	          range.collapse(true);
	          sel.removeAllRanges();
	          sel.addRange(range);
	        }
	      }
	      this.update({ target:this._children.inp});
	    }
	  }

	  keydown(e){
	      if( e.keyCode == 13 ){
	        e.preventDefault();
	        this.putAtCaret(' \n<br>\u200B');
	        return false;
	      }
	  }
	  
	  paste(e){
	    e.preventDefault();
	    var data = (e.clipboardData || window.clipboardData).getData('Text').replace(/\r/g, '').replace(/\n/g, '\n<br />');
	    document.execCommand('insertHTML', false, data);
	  }
	}

	customElements.define('mini-editor', MiniEditor);
</script>


<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
