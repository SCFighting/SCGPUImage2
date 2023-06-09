#if canImport(OpenGL)
import OpenGL.GL3
#endif

#if canImport(OpenGLES)
import OpenGLES
#endif

#if canImport(COpenGLES)
import COpenGLES.gles2
#endif

#if canImport(COpenGL)
import COpenGL
#endif
import AVFoundation
public class RawDataOutput: ImageConsumer {
    public var dataAvailableCallback:(([UInt8], _ width:GLint, _ height:GLint) -> ())?
    public var dataAvailableCallbackSize:(([UInt8], _ frameBuffer: Framebuffer, _ cmtime: CMTime) -> ())?
    
    public let sources = SourceContainer()
    public let maximumInputs:UInt = 1

    public init() {
    }

    // TODO: Replace with texture caches
    public func newFramebufferAvailable(_ framebuffer:Framebuffer, fromSourceIndex:UInt) {
        let renderFramebuffer = sharedImageProcessingContext.framebufferCache.requestFramebufferWithProperties(orientation:framebuffer.orientation, size:framebuffer.size)
        renderFramebuffer.lock()

        renderFramebuffer.activateFramebufferForRendering()
        clearFramebufferWithColor(Color.black)
        renderQuadWithShader(sharedImageProcessingContext.passthroughShader, uniformSettings:ShaderUniformSettings(), vertexBufferObject:sharedImageProcessingContext.standardImageVBO, inputTextures:[framebuffer.texturePropertiesForOutputRotation(.noRotation)])
        framebuffer.unlock()
        
        var data = [UInt8](repeating:0, count:Int(framebuffer.size.width * framebuffer.size.height * 4))
        glReadPixels(0, 0, framebuffer.size.width, framebuffer.size.height, GLenum(GL_BGRA), GLenum(GL_UNSIGNED_BYTE), &data)
        renderFramebuffer.unlock()
//        print("framebuffer.size.width=\(framebuffer.size.width),framebuffer.size.height=\(framebuffer.size.height),framebuffer.orientation=\(framebuffer.orientation)\n")
        dataAvailableCallback?(data,framebuffer.size.width,framebuffer.size.height)
        
        var time: CMTime = CMTime(seconds: 0, preferredTimescale: 1000)
        if let timestamp = framebuffer.timingStyle.timestamp {
            time = CMTime(value: timestamp.value, timescale: timestamp.timescale)
        }
        dataAvailableCallbackSize?(data, framebuffer, time)
    }
}
