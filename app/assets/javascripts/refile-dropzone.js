var idNew, input;
var cancel_flag = false;
var ItemArray = [];
(function() {
  "use strict";
  function isSuccess(xhr) {
    return (xhr.status >= 200 && xhr.status < 300) || xhr.status === 304
  }
  function formData(as, file, fields) {
    var data = new FormData();

    if(fields) {
      Object.keys(fields).forEach(function(key) {
        data.append(key, fields[key]);
      });
    }
    data.append(as, file);
    return data;
  }
  if(!document.addEventListener) { return; } // IE8
  document.addEventListener("change", function(changeEvent) {
    input = changeEvent.target;
    if(input.tagName === "INPUT" && input.type === "file" && input.getAttribute("data-direct")) {
      if(!input.files) { return; } // IE9, bail out if file API is not supported.
      var reference = input.getAttribute("data-reference");
      var metadataField = document.querySelector("input[type=hidden][data-reference='" + reference + "']");
      var url = input.getAttribute("data-url");
      var fields = JSON.parse(input.getAttribute("data-fields") || "null");
      var requests = [].map.call(input.files, function(file, index) {
        function dispatchEvent(element, name, progress) {
          var ev = document.createEvent('CustomEvent');
          ev.initCustomEvent(name, true, false, { xhr: xhr, file: file, index: index, progress: progress });
          element.dispatchEvent(ev);
        }
        var xhr = new XMLHttpRequest();
        xhr.file = file;
        xhr.addEventListener("load", function() {
          xhr.complete = true;
          if(requests.every(function(xhr) { return xhr.complete; })) {
            finalizeUpload();
          }
          if(isSuccess(xhr)) {
            dispatchEvent(input, "upload:success");
          } else {
            dispatchEvent(input, "upload:failure");
          }
          dispatchEvent(input, "upload:complete");
        });
        xhr.upload.addEventListener("progress", function(progressEvent) {
          dispatchEvent(input, "upload:progress", progressEvent);
          progress_match(file, progressEvent); //Llama a la funcion para mostrar progressbar con dropzone
        });
        if(input.getAttribute("data-presigned")) {
          dispatchEvent(input, "presign:start");
          var presignXhr = new XMLHttpRequest();
          var presignUrl = url + "?t=" + Date.now() + "." + index;
          presignXhr.addEventListener("load", function() {
            dispatchEvent(input, "presign:complete");
            if(isSuccess(presignXhr)) {
              dispatchEvent(input, "presign:success");
              var data = JSON.parse(presignXhr.responseText)
              xhr.id = data.id;
              xhr.open("POST", data.url, true);
              xhr.send(formData(data.as, file, data.fields));
              dispatchEvent(input, "upload:start");
            } else {
              dispatchEvent(input, "presign:failure");
              xhr.complete = true;
            };
          });
          presignXhr.open("GET", presignUrl, true);
          presignXhr.send();
        } else {
          xhr.open("POST", url, true);
          xhr.send(formData(input.getAttribute("data-as"), file, fields));
          dispatchEvent(input, "upload:start");
        }
        return xhr;
      });
      if(requests.length) {
        input.classList.add("uploading");
      }
      var finalizeUpload = function() {
        input.classList.remove("uploading");
        if(requests.every(isSuccess)) {
          var data = requests.map(function(xhr) {
            var id = xhr.id || JSON.parse(xhr.responseText).id;
            return { id: id, filename: xhr.file.name, content_type: xhr.file.type, size: xhr.file.size };
          });
          if ( input.multiple ) {
            var arrayInit;
            data.forEach(function(entry) {
              arrayInit = entry;
              ItemArray.push(arrayInit);
            });
            if(metadataField) metadataField.value = JSON.stringify(ItemArray);
          } else {
            data = data[0];
            if (cancel_flag == false && metadataField.value === "{}" || !metadataField.value ) {
              $('.fileUploadedCheck').parent().parent().fadeOut('slow');
              metadataField.value = JSON.stringify(data);
              var metadata = document.querySelector("input[type=file][data-reference='" + reference + "']");
              var remove_name = $(metadata).attr("data-remove-hidden-name");
              $("input[name='"+remove_name+"']").val('0');
            }
          }
          input.removeAttribute("name");
        }
      }
    }
  });
})();
// Funciones para que Refile haga el post al arrastrar y soltar archivos al Dropzone
function functionChangeFict(this2, e){
  function isSuccess(xhr) {
    return (xhr.status >= 200 && xhr.status < 300) || xhr.status === 304
  }
  function formData(as, file, fields) {
    var data = new FormData();

    if(fields) {
      Object.keys(fields).forEach(function(key) {
        data.append(key, fields[key]);
      });
    }
    data.append(as, file);
    return data;
  }
  // Variables y elementos de Dropzone
  var filesToSend = e.dataTransfer.files;
  var input = $('.dz-hidden-input')[0];
  input.setAttribute("id", "inputTouch");
  var reference = $(".attachment .optional").attr("data-reference");
  var url = $(".attachment .optional").attr("data-url");

  if(input.tagName === "INPUT" && input.getAttribute("data-direct")) {
    if(!filesToSend) { return; } // IE9, bail out if file API is not supported.

    var reference = input.getAttribute("data-reference");
    var metadataField = document.querySelector("input[type=hidden][data-reference='" + reference + "']");
    var url = input.getAttribute("data-url");
    var fields = JSON.parse(input.getAttribute("data-fields") || "null");
    var requests = [].map.call(filesToSend, function(file, index) {
      function dispatchEvent(element, name, progress) {
        var ev = document.createEvent('CustomEvent');
        ev.initCustomEvent(name, true, false, { xhr: xhr, file: file, index: index, progress: progress });
        element.dispatchEvent(ev);
      }
      var xhr = new XMLHttpRequest();
      xhr.file = file;
      xhr.addEventListener("load", function() {
        xhr.complete = true;
        if(requests.every(function(xhr) { return xhr.complete })) {
          finalizeUpload();
        }
        if(isSuccess(xhr)) {
          dispatchEvent(input, "upload:success");
        } else {
          dispatchEvent(input, "upload:failure");
        }
        dispatchEvent(input, "upload:complete");
      });
      xhr.upload.addEventListener("progress", function(progressEvent) {
        dispatchEvent(input, "upload:progress", progressEvent);
        progress_match(file, progressEvent); //Llama a la funcion para mostrar progressbar con dropzone
      });
      if(input.getAttribute("data-presigned")) {
        dispatchEvent(input, "presign:start");
        var presignXhr = new XMLHttpRequest();
        var presignUrl = url + "?t=" + Date.now() + "." + index;
        presignXhr.addEventListener("load", function() {
          dispatchEvent(input, "presign:complete");
          if(isSuccess(presignXhr)) {
            dispatchEvent(input, "presign:success");
            var data = JSON.parse(presignXhr.responseText);
            xhr.id = data.id;
            idNew = id;
            xhr.open("POST", data.url, true);
            xhr.send(formData(data.as, file, data.fields));
            dispatchEvent(input, "upload:start");
          } else {
            dispatchEvent(input, "presign:failure");
            xhr.complete = true;
          };
        });
        presignXhr.open("GET", presignUrl, true);
        presignXhr.send();
      } else {
        xhr.open("POST", url, true);
        xhr.send(formData(input.getAttribute("data-as"), file, fields));
        dispatchEvent(input, "upload:start");
      }
      return xhr;
    });
    if(requests.length) {
      input.classList.add("uploading");
    }
    var finalizeUpload = function() {
      input.classList.remove("uploading");
      if(requests.every(isSuccess)) {
        var data = requests.map(function(xhr) {
          var id = xhr.id || JSON.parse(xhr.responseText).id;
          return { id: id, filename: xhr.file.name, content_type: xhr.file.type, size: xhr.file.size };
        });
        //if(!input.multiple) data = data[0];
        if ( input.multiple ) {
          var arrayInit;
          data.forEach(function(entry) {
            arrayInit = entry;
            ItemArray.push(arrayInit);
          });
          if(metadataField) metadataField.value = JSON.stringify(ItemArray);
        } else {
          data = data[0];
          //$(metadataField).removeAttr('value');
          if (cancel_flag == false ||metadataField.value === "{}" || !metadataField.value ) {
            $('.fileUploadedCheck').parent().parent().fadeOut('slow');
            metadataField.value = JSON.stringify(data);
            var metadata = document.querySelector("input[type=file][data-reference='" + reference + "']");
            var remove_name = $(metadata).attr("data-remove-hidden-name");
            $("input[name='"+remove_name+"']").val('0');
            if (input.multiple) {
              $(file._removeLink).html(this.Dropzone.options.dropzoneMultiple.dictRemoveFile);
            } else {
              $(file._removeLink).html(this.Dropzone.options.dropzoneSimple.dictRemoveFile);
            }
          }
        }
        input.removeAttribute("name");
      }
    }
  }
}

function processing(file) {
  if (file.previewElement) {
    file.previewElement.classList.add("dz-processing");
    if (file._removeLink) {
      if (input.multiple) {
        $(file._removeLink).html(this.Dropzone.options.dropzoneMultiple.dictCancelUpload);
      } else {
        $(file._removeLink).html(this.Dropzone.options.dropzoneSimple.dictCancelUpload);
      }
    }
  }
}
////////////// Cuenta el progreso de subida del archivo para mostrarlo en la barra de dropzone //////////////////
function progress_match(file, progressEvent){
  file.processing = true;
  file.status = Dropzone.UPLOADING;
  processing(file);
	$("button[type=submit]").attr("disabled", true);
	var percentage = Math.round( (progressEvent.loaded / progressEvent.total) * 100);
	var progress = percentage;
	var node, _i, _len, _ref, _results;
	if (file.previewElement) {
		_ref = file.previewElement.querySelectorAll("[data-dz-uploadprogress]");
		_results = [];
		for (_i = 0, _len = _ref.length; _i < _len; _i++) {
			node = _ref[_i];
			if (node.nodeName === 'PROGRESS') {
				_results.push(node.value = progress);
			} else {
				_results.push(node.style.width = "" + progress + "%");
			}
		}
      setTimeout(function(){
        return successProgress(file);
      }, 500);
	}
	function successProgress(file){
		if (cancel_flag == false && percentage === 100) {
			$("button[type=submit]").prop('disabled', false);
			$(".dz-progress").fadeOut("slow");
      if (input.multiple) {
        $(file._removeLink).html(this.Dropzone.options.dropzoneMultiple.dictRemoveFile);
      } else {
        $(file._removeLink).html(this.Dropzone.options.dropzoneSimple.dictRemoveFile);
      }
      file.status = Dropzone.ADDED;
			return file.previewElement.classList.add("dz-success");
		};
    if (cancel_flag == true) {
      $("button[type=submit]").prop('disabled', false);
      return file.previewElement.classList.remove("dz-success");
		}
	}
}
